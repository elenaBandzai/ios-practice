//
//  ProductListInteractor.swift
//  Preloved
//
//  Created by Elena Bandzaite on 25/11/2026.
//

import Foundation

protocol ProductListBusinessLogic {
    func loadProducts() async
}

final class ProductListInteractor: ProductListBusinessLogic {
    private let presenter: ProductListPresentationLogic
    private let service: ProductServiceProtocol
    private var isLoading = false
    
    init(presenter: ProductListPresentationLogic, service: ProductServiceProtocol) {
        self.presenter = presenter
        self.service = service
    }
    
    func loadProducts() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        presenter.presentLoading()

        do {
            let products = try await service.fetchProducts()
            let response = ProductList.Response(products: products)
            presenter.presentProducts(response: response)
        } catch {
            print("Error: \(error)")
        }
    }

}
