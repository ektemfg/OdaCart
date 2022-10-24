//
//  DataService.swift
//  OdaCart
//
//  Created by Dimitrije Pesic on 17/10/2022.
//
/*
 Api lenke:
https://api.npoint.io/d4e0a014b1cfc5254bcb
 Mocken:
 https://www.figma.com/file/eoU8ArjtQ7sIxtwLHXbIpG/iOS-Temaoppgave-7?node-id=0%3A1
*/

/*
 Vi henter ting fra API lenken , decoder det om til vår Cart klasse og retunerer det. Vi kaller på DataService fra ViewModellen.
 */

import Foundation
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
