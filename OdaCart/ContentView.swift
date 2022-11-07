import SwiftUI

struct ContentView: View {
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject private var addedCartItems = AddedCartItems()
    @State var showPrices: Bool = true
    
    //TODO: Replace navbar title with Text view. It would be more clean and less code by simply using a Text View to present a title instead of toolbar item.
    
    
    init() {
        
        // This function is called when the ContentView is first initialized.
        // Adds a custom appearance to the navbar so that it does not have a gray background.

        // A lot of this is just for dark mode to look good.
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance.shadowColor = .clear
        
        // I gave TableView a custom appearance
        let tableViewApperance = UITableView.appearance()
        tableViewApperance.backgroundColor = UIColor(Color("backgroundColor"))
        tableViewApperance.contentInset.top = -35
        
        // I gave TableViewCell a custom appearance
        let tableViewCellApperance = UITableViewCell.appearance()
        tableViewCellApperance.backgroundColor = UIColor(Color("backgroundColor"))
    }
    
    var body: some View {
        GeometryReader{ proxy in
            NavigationView {
                VStack() {
                    // I choose not to remove the CellView of an item from the list if no items of its type are in the cart, instead just collapse buttons into one.
                    if let cartItems = cartViewModel.cart?.items {
                        HStack {
                            List(cartItems) { that in
                                CartItemView(item: that, addedCartItems: addedCartItems, viewModel: cartViewModel)
                                
                                
                            }
                            .listStyle((.grouped))
                            .frame(maxHeight: .infinity)
                            
                        }
                        
                    }
                    
                    
                    
                    // We will check if there are any items in the cart by checking the bool value of isSummaryVisible.
                    if addedCartItems.isSummaryVisible {
                        HStack{
                            CartSummary(addedCartItems: addedCartItems)
                            
                        }
                        
                        
                        
                    }
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar{
                    ToolbarItem(placement: .principal) {
                        Text("Shopping Cart")
                            .foregroundColor(Color("textColor"))
                            .font(.system(size:22, weight: .semibold, design:.rounded))
                        
                        
                    }
                    
                }
                
            }.navigationViewStyle(.stack)
            
            
            
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
