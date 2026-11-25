//
//  ProductService.swift
//  Preloved
//
//  Created by Elena Bandzaite on 24/11/2026.
//

import Foundation

nonisolated struct ProductsResponse: Decodable {
    let products: [Product]
}

protocol ProductServiceProtocol {
    func fetchProducts() async throws -> [Product]
}

struct ProductService: ProductServiceProtocol {
    private let url = URL(string: "https://dummyjson.com/products?limit=30")!

    func fetchProducts() async throws -> [Product] {
        let (data, _) = try await URLSession.shared.data(from: url) //returns a tuple [data, response]
        
        let response = try JSONDecoder().decode(ProductsResponse.self, from: data)
        return response.products
    }
}
