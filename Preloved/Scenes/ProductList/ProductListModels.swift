import Foundation

enum ProductList {

    struct Response {
        let products: [Product]
    }

    enum ViewModel: Equatable {
        case loading
        case loaded([DisplayedProduct])
        case error(message: String)
    }

    struct DisplayedProduct: Equatable {
        let title: String
        let price: String
        let imageURL: URL
    }
}
