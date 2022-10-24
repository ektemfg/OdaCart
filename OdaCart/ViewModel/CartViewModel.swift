//
//  CartViewModel.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 17/10/2022.
//

import Foundation
import SwiftUI

class CartViewModel: ObservableObject {
    @Published var cart : Cart? = nil
    @Published var isSummaryVisible: Bool = false
    @ObservedObject var addedCartItems = AddedCartItems()
    private let dataService = DataService()
    
    init()  {
        Task {
            do{
                await updateCart()

            }
        }
        
    }
    
    @MainActor
    func updateCart() {
        Task {
            do{
                cart = try await dataService.fetchCart()
            } catch {
                print(error)
            }
        }
    }
    
    func returnCartItems() -> [Item] {
        return cart!.items
    }
    
    
   /* func updateSummaryItemCount(item: Item) {
        let itemPrice = Double(item.product.grossPrice!)
        itemCount = addedCartItems.cartItems.count
        totalPrice += itemPrice!
    }
    */
    
    
    // Returnerer false hvis det finnes discount. Litt omvendt psykologi
     func checkDiscount(item: Item) -> Bool {
        return item.displayPriceTotal != item.discountedDisplayPriceTotal
    }
    
    /*
     Skulle egentlig bruke dette for å få en eksempel item i previews tidligere men har ikke bruk for det nå.
    func returnExampleItem() -> Item {
        return cart!.items[0]
    }
     */
        
}
