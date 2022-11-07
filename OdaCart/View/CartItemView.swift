import Foundation
import SwiftUI

struct CartItemView : View {
    let item: Item
    @ObservedObject var addedCartItems: AddedCartItems
    @ObservedObject var viewModel: CartViewModel
    @State var isSelected: Bool = false
    @State var soldOutAlertShowing: Bool = false
    
    
    
    
    
    var body: some View {
        // I chose to use NavLink to show LargeItemView which contains product name, price and image rather than simply creating an onTapGesture to scale the image to fullscreen.
        
        HStack(spacing:0) {
            AsyncImage(url: URL(string: item.product.images[0].thumbnail.url)) { image in
                ZStack{
                    image
                        .resizable()
                        .scaledToFill()
                        .onTapGesture {
                            isSelected.toggle()
                            
                        }
                    
                    
                        .padding()
                    NavigationLink(destination: LargeItemView(item: item), isActive: $isSelected){}.opacity(0)
                        .frame(width: 0, height: 0)
                }
            }
            
        placeholder: {
            ProgressView()
                .padding()
            
        }
        .frame(width: 70, height: 70, alignment: .trailing)
            
            //TODO: Create overlay that states SALE in top leading corner of the image.
            
            VStack(alignment:.leading) {
                Text(item.product.name)
                    .font(.system(size:14, weight: .medium, design:.rounded))
                    .lineLimit(1)
                
                // If the product (item) is not available, we will show out of stock instead of nameExtra value.
                if item.product.availability.isAvailable == false {
                    Text("Out of stock")
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .lineLimit(1)
                        .foregroundColor(Color.red)
                } else {
                    // If the product is available, we show nameExtra value.
                    Text(item.product.nameExtra ?? "")
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .lineLimit(1)
                }
                
                
            }
            Spacer()
            
            // We check several conditions, and considering them we have a choice of color, text, etc. For example, if the product is on sale we use saleColor as foregroundColor and strikethrough.
            if !addedCartItems.contains(item) {
                VStack(alignment:.trailing) {
                    Text("kr " + (item.product.grossPrice?.replacingOccurrences(of: ".", with: ",") ?? ""))
                        .font(.system(size:14, weight: .bold, design:.rounded))
                    
                        .foregroundColor(!viewModel.checkDiscount(item: item) ? Color("textColor") : Color("saleColor"))
                    Text((((!viewModel.checkDiscount(item: item) ? "kr " + item.product.grossUnitPrice.replacingOccurrences(of: ".", with: ",") + "/\(item.product.unitPriceQuantityAbbreviation)" : item.product.discount?.undiscountedGrossPrice)!)))
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .strikethrough(!viewModel.checkDiscount(item: item) ? false : true)
                }
            }
            
            // If we do not have the product in AddedCartItems, we should only present yellow plus button which will add the item in cart.
            if !addedCartItems.contains(item) {
                HStack(alignment:.center){
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .foregroundColor(item.product.availability.isAvailable ? Color("addButtonColor") : .gray)
                        .onTapGesture {
                            item.product.availability.isAvailable ? addedCartItems.add(item) : soldOutAlertShowing.toggle()
                        }
                        .padding(.leading, 20)
                }
            } else {
                //Otherwise, we will show the minus and plus signs and the count of that product in the cart (addedCartItems)
                HStack(alignment:.center){
                    Spacer()
                    Image(systemName: "minus.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .font(Font.title.weight(.thin))
                        .onTapGesture(perform: {
                            addedCartItems.remove(item)
                        })
                    Text(String(addedCartItems.specificItemCount(item: item)))
                        .font(.system(size:14, weight: .medium, design:.rounded))
                    Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 32, height: 32)
                        .font(Font.title.weight(.thin))
                        .onTapGesture {
                            addedCartItems.add(item)
                        }
                    
                }
                
            }
            
        } .alert(isPresented: $soldOutAlertShowing, content: {
            Alert(title: Text("Unnskyld"), message: Text("Produktet er utsolgt"), dismissButton: .default(Text("OK")))
        }
        )
    }
}
