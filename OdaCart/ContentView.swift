//
//  ContentView.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 17/10/2022.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var cartViewModel = CartViewModel()
    @ObservedObject private var addedCartItems = AddedCartItems()
    @State var showPrices: Bool = true
    
    
    
    
    init() {
        
        // Her gjør ting med engang ContentView blir initialisert
        // Legger en custom apperance til navbaren, slik at den ikke har en grå bakgrunn. Kunne egt brukt Text view som tittel, men ville gjøre det på denne måten. Det var mye pain men jeg var sta at jeg ville bruke navbar istedenfor. Fikk det til å funke bra, men kan bli litt rar av og til i darkmode.
        // Egentlig er mye av det her for å ha darkmode til på se bra ut.
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().standardAppearance.shadowColor = .clear
        
        // Prøvde å gi custom apperance til TableView
        let tableViewApperance = UITableView.appearance()
        tableViewApperance.backgroundColor = UIColor(Color("backgroundColor"))
        tableViewApperance.contentInset.top = -35
        
        // Prøvde å gi custom apperance til TableViewCells
        let tableViewCellApperance = UITableViewCell.appearance()
        tableViewCellApperance.backgroundColor = UIColor(Color("backgroundColor"))
    }
    
    var body: some View {
        GeometryReader{ proxy in
            NavigationView {
                VStack() {
                    // Tror egt vi skulle gjort det mulig å fjerne ting fullstendig fra liste, men var ikke sikker det er meningen. Å gjøre det mulig å adde og fjerne ting ved å bruke tilgjengelige produkter mener jeg er mye bedre. Det hadde vært dumt å ha liste av produkter også  la oss si legge til 2, og når vi fjerner disse 2 fra handlekurven fjerne selve produkt CellViewen fra lista. For meg gir det ikke mening. Derfor valgte jeg å ha det slik som her.
                    if let cartItems = cartViewModel.cart?.items {
                        HStack {
                            List(cartItems) { that in
                                CartItemView(item: that, addedCartItems: addedCartItems, viewModel: cartViewModel)
                                
                                
                            }
                            .listStyle((.grouped))
                            .frame(maxHeight: .infinity)
                            
                        }
                        
                    }
                    
                    
                    
                    // har vi noe i handlekuven fra før? vi sjekker isSummaryVisible variabelen fra addedCartItems
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
