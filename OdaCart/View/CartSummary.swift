import Foundation
import SwiftUI

// The Cart Summary is a view we call when we have products in the cartItems list. It shows how many products there are in the list, and in addition the total price. Values are fetched from addedCartItems.


struct CartSummary: View {
    @ObservedObject var addedCartItems: AddedCartItems
    
    var body: some View {
        HStack() {
            Image(systemName: "cart")
            Text(String(addedCartItems.cartItems.count) + " products")
                .foregroundColor(Color("textColor"))
            
            Spacer()
            Text("kr " + String(format:"%.2f", addedCartItems.totalPrice).replacingOccurrences(of: ".", with: ","))
                .foregroundColor(Color("textColor"))
        }
        .font(.system(size:14, weight: .bold))
        .padding()
        .background(Color("summaryBackgroundColor"))
    }
    
}
