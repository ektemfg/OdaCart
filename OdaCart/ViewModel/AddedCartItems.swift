import Foundation

class AddedCartItems: ObservableObject {
    var cartItems: [Item] = []
    private let saveKey = "AddedCartItems"
    let defaults = UserDefaults.standard
    @Published var itemCount = 0
    @Published var totalPrice: Double = 0
    @Published var isSummaryVisible = false
    
    
    init() {
        
        // We are trying to retrieve stored items from UserDefaults, and put them in cartItems. We also retrieve the last-stored totalPrice. This could have been done more cleanly, but I really wanted to solve this problem so that I could focus on further development of the app.
        
        if let items = UserDefaults.standard.object(forKey: "AddedCartItems") as? Data {
            cartItems = try! JSONDecoder().decode([Item].self, from: items)
            
            
            itemCount = cartItems.count
            totalPrice = defaults.double(forKey: "lastTotal") ?? 0.0
            
            // Make the summary visible if cartItems is not empty. These are values that are observed in CartSummary from AddedCartItems
            
            isSummaryVisible = !cartItems.isEmpty
    }
    }
    
    // Function to check if cartItems contains a specific item.
    func contains(_ cartItem: Item) -> Bool {
        return cartItems.contains(cartItem)
    }
    
    // Adds an item to the cartItems list, changes the itemCount and finally executes save () function.
    
    func add(_ cartItem:Item) {
        objectWillChange.send()
        cartItems.append(cartItem)
        itemCount += 1
        totalPrice += Double(cartItem.product.grossPrice!)!
        isSummaryVisible = true
        save()
    }
    
    // Remove a specific item from the cartItems list.
    
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
    
    // How many of that exact product are there in the cartItems list?
    
    func specificItemCount(item: Item) -> Int {
        return cartItems.filter { $0.product.id == item.product.id }.count
        
    }

    
    // Saves totalPrice with lastTotal key and cartItems to to UserDefaults as a encoded object to be able to retrieve it at app restart.
    func save() {
        // TODO: Make struct that contains cartItems and lastTotal, so we can save it together in UserDefaults.
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(cartItems) {
            defaults.set(encoded, forKey: saveKey)
            defaults.set(totalPrice, forKey: "lastTotal")
        }
    }
 }
