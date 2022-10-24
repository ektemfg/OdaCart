//
//  CartItemView.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 19/10/2022.
//

import Foundation
import SwiftUI

struct CartItemView : View {
    let item: Item
    @ObservedObject var addedCartItems: AddedCartItems
    @ObservedObject var viewModel: CartViewModel
    @State var isSelected: Bool = false
    @State var soldOutAlertShowing: Bool = false
    
    
    
    
    
    var body: some View {
        // Her valgte jeg å bruke NavLink til å vise LargeItemView, istedenfor å kun gi en onTapGesture fullscreen skaleringen av bilde eller evt bare sende til en view som viser kun bildet i fullscreen. Jeg valgte å bruke kunnskap om navigasjon til å ha egen view som viser produkt navn, pris og stort bilde (selvom jeg bruker thumbnail urlen så er bilde i høy oppløsning og ser bra ut)
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
            /*
             Tenkte ha shape og text som overlay i hjørnet til bilde om det er salg, men velger det bort.
        .overlay(!viewModel.checkDiscount(item: item) ?
                 
                 Text(item.product.promotion?.title ?? "Salg!")
            .foregroundColor(Color.white)
                 
                 : Text("")
        )
             */
            
            VStack(alignment:.leading) {
                Text(item.product.name)
                    .font(.system(size:14, weight: .medium, design:.rounded))
                    .lineLimit(1)
                
                // Om produktet (item) ikke er tilgjengelig så skal vi vise out of stock istedenfor nameExtra
                if item.product.availability.isAvailable == false {
                    Text("Out of stock")
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .lineLimit(1)
                        .foregroundColor(Color.red)
                } else {
                    // Ellers viser vi nameExtra. For sikkerhetskyld bruker jeg ?? "".
                    Text(item.product.nameExtra ?? "")
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .lineLimit(1)
                }
                
                
            }
            Spacer()
            
            // Her sjekker vi også flere conditions, og med tanke på de har vi valg av farge, tekst osv. Om for eksempel produktet er på tilbud bruker vi addButtonColor som foregroundColor og strikethrough. Jeg er klar over at denne koden kan gjøres kortere og ryddigere.
            if !addedCartItems.contains(item) {
                VStack(alignment:.trailing) {
                    Text("kr " + (item.product.grossPrice?.replacingOccurrences(of: ".", with: ",") ?? ""))
                        .font(.system(size:14, weight: .bold, design:.rounded))
                    
                        .foregroundColor(!viewModel.checkDiscount(item: item) ? Color("textColor") : Color("addButtonColor"))
                    Text((((!viewModel.checkDiscount(item: item) ? "kr " + item.product.grossUnitPrice.replacingOccurrences(of: ".", with: ",") + "/\(item.product.unitPriceQuantityAbbreviation)" : item.product.discount?.undiscountedGrossPrice)!)))
                        .font(.system(size:14, weight: .regular, design:.rounded))
                        .strikethrough(!viewModel.checkDiscount(item: item) ? false : true)
                }
            }
            
            // Hvis vi ikke har produktet i AddedCartItems skal vi ha bare en gul + knapp som adder den i addedCartItems.
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
            }else {
                //Eller skal vi vise minus og plus og antall av det produktet i kurven (addedCartItems)
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
        })
        
        
        
        
        
        
    }
    
}
