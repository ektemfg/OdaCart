import Foundation
/*
 We fetch data from the API,  decode it as our Cart class and return it. We call DataService from the ViewModel.
 */
struct DataService {
    private static let  baseUrl = "https://api.npoint.io/"
    private static let  endPoint = "d4e0a014b1cfc5254bcb"
    private let finalUrl = baseUrl+endPoint
    
    private func performRequest(_ url:String) async throws -> Cart{
        let apiUrl = URL(string: finalUrl)
        let request = URLRequest(url: apiUrl!)
        let (data,_) = try await URLSession.shared.data(for: request)
        let cartData = try JSONDecoder().decode(Cart.self, from: data)
        return cartData
    }
    
    func fetchCart() async throws -> Cart {
        return try await performRequest(finalUrl)
    }
}
