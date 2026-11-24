import Foundation
import Testing
@testable import Preloved

struct ProductTests {

    @Test func decodesProductFromJSON() throws {
        let json = """
        {
            "id": 1,
            "title": "Denim Jacket",
            "description": "Barely worn",
            "price": 24.99,
            "brand": "Levi's",
            "thumbnail": "https://example.com/jacket.png",
            "rating": 4.5
        }
        """
        let data = Data(json.utf8)

        let product = try JSONDecoder().decode(Product.self, from: data)

        #expect(product.id == 1)
        #expect(product.title == "Denim Jacket")
        #expect(product.brand == "Levi's")
    }
    
    @Test func decodesProductWithoutBrand() throws {
        let json = """
        {
            "id": 1,
            "title": "Denim Jacket",
            "description": "Barely worn",
            "price": 24.99,
            "thumbnail": "https://example.com/jacket.png"
        }
        """
        let data = Data(json.utf8)

        let product = try JSONDecoder().decode(Product.self, from: data)

        #expect(product.id == 1)
        #expect(product.title == "Denim Jacket")
        #expect(product.brand == nil)
    }
}
