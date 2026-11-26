import Foundation

extension Product {
    static func sample(
        title: String = "Denim Jacket",
        description: String = "Barely worn, great condition. Size M.",
        brand: String? = "Levi's"
    ) -> Product {
        Product(
            id: 1,
            title: title,
            description: description,
            price: 24.99,
            brand: brand,
            thumbnail: URL(string: "https://example.com/jacket.png")!
        )
    }
}
