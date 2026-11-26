import Foundation

nonisolated struct Product: Decodable, Equatable {
    let id: Int
    let title: String
    let description: String
    let price: Double
    let brand: String?
    let thumbnail: URL
}
