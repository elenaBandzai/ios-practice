//
//  Product.swift
//  Preloved
//
//  Created by Elena Bandzaite on 24/11/2026.
//

import Foundation

nonisolated struct Product: Decodable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let brand: String?
    let thumbnail: URL
}
