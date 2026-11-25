//
//  ProductListModels.swift
//  Preloved
//
//  Created by Elena Bandzaite on 25/11/2026.
//

import Foundation

enum ProductList {

    struct Response {
        let products: [Product]
    }

    enum ViewModel {
        case loading
        case loaded([DisplayedProduct])
        case error(message: String)
    }

    struct DisplayedProduct {
        let title: String
        let price: String
    }
}
