//
//  AddedCartItems.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 19/10/2022.
//

import Foundation

class AddedCartItems: ObservableObject {
    var cartItems: [Item] = []
    private let saveKey = "AddedCartItems"
    let defaults = UserDefaults.standard
    @Published var itemCount = 0
    @Published var totalPrice: Double = 0
    @Published var isSummaryVisible = false
    
    
    init() {
        
        // Vi prøver å hente lagret ting fra UserDefaults, og putter det i cartItems. Vi henter også sist-lagret totalPrice. Dette kunne blitt gjort ryddigere, men jeg ville så gjerne løse dette problemet slik at jeg kunne fokusere på videreutvikling av appen.
        
        if let items = UserDefaults.standard.object(forKey: "AddedCartItems") as? Data {
            cartItems = try! JSONDecoder().decode([Item].self, from: items)
            
            // Antall ting i Carten
            
            itemCount = cartItems.count
            
            // Hente siste pris. Prøvde å gi verdi om den ikke finner verdi for lasttotal keyen men virker som unødvendig da Summary ikke vises uansett om cartItems er tomt...
            totalPrice = defaults.double(forKey: "lastTotal") ?? 0.0
            
            // Gjør summaryen synlig om cartItems ikke er tomt. Dette er verdier som blir observa i CartSummary fra AddedCartItems
            
            isSummaryVisible = !cartItems.isEmpty
    }
    }
    
    // Funksjon som sjekker om cartItems inneholder spesifik item.
    func contains(_ cartItem: Item) -> Bool {
        return cartItems.contains(cartItem)
    }
    
    // Legger en item i cartItems lista, endrer itemCounten (kunne evt gjort at den bare sjekker cartItems count egentlig men skal se på det senere. isSummaryVisible og itemCount veridendring gjør at IT WORKS. So vil ikke fikse noe som fungerer foreløpig. Til slutt kjører den save() som jeg forklarer lenger ned.
    
    func add(_ cartItem:Item) {
        objectWillChange.send()
        cartItems.append(cartItem)
        itemCount += 1
        totalPrice += Double(cartItem.product.grossPrice!)!
        isSummaryVisible = true
        save()
    }
    
    // Sletter spesifikk item fra cartItems lista.
    
    func remove(_ cartItem:Item) {
        objectWillChange.send()
        if let index = cartItems.firstIndex(of: cartItem) {
            cartItems.remove(at: index)
        }
        if itemCount == 1 {
            isSummaryVisible = false
        }
        itemCount -= 1
        totalPrice -= Double(cartItem.product.grossPrice!)!
        save()
    }
    
    // Bruker ikke. Unødvendig funksjon.
    
    /* func isItEmpty() -> Bool {
        return cartItems.isEmpty
    }
     */
    
    // Hvor mange av akkurat det produktet er det i cartItems lista? Dette er en nyttig funksjon som jeg bruker for å vise antall av samme produkt vi har lagt inn i lista.
    func specificItemCount(item: Item) -> Int {
        return cartItems.filter { $0.product.id == item.product.id }.count
        
    }

    
    // Lagrer cartItems i sin helhet i UserDefaults encoda, og i tillegg totalPrice i lastTotal keyen for å kunne hente det ut ved app restart. Dette kunne gjøres på en bedre måte, men fungerer slik foreløpig vil jeg ikke endre det.
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cartItems) {
            defaults.set(encoded, forKey: saveKey)
            defaults.set(totalPrice, forKey: "lastTotal")
        }
    }
 }
