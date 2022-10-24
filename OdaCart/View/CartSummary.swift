//
//  CartSummary.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 20/10/2022.
//

import Foundation
import SwiftUI

// CartSummary er en view vi kaller når vi har produkter i cartItems lista. Den viser hvor mange produkter det er i lista, og i tillegg samlet pris. Henter sine verdier fra addedCartItems.


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
