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
    
    // Checks if priceTotal is not same as discountedPrice  therefore checks if item is on sale.
     func checkDiscount(item: Item) -> Bool {
        return item.displayPriceTotal != item.discountedDisplayPriceTotal
    }
        
}

// TODO: Fix Preview.
