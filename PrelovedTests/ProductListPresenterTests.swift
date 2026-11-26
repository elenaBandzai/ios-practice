//
//  ProductListPresenterTests.swift
//  PrelovedTests
//
//  Created by Elena Bandzaite on 26/11/2026.
//

import Foundation
import Testing
@testable import Preloved

@MainActor
final class DisplaySpy: ProductListDisplayLogic {
    var viewModels: [ProductList.ViewModel] = []

    func display(viewModel: ProductList.ViewModel) {
        viewModels.append(viewModel)
    }
}

@MainActor
struct ProductListPresenterTests {

    @Test func presentProductsFormatsPriceForDisplay() {
        // Arrange
        let spy = DisplaySpy()
        let presenter = ProductListPresenter(priceFormatter: PriceFormatter(locale: Locale(identifier: "en_US")))
        presenter.viewController = spy
        let product = Product.sample()

        // Act
        presenter.presentProducts(response: ProductList.Response(products: [product]))

        // Assert
        let expected = ProductList.DisplayedProduct(
            title: "Denim Jacket",
            price: "€24.99",
            imageURL: product.thumbnail
        )
        #expect(spy.viewModels == [.loaded([expected])])
    }
    
    @Test func presentErrorShowsMessage() {
        let spy = DisplaySpy()
        let presenter = ProductListPresenter()
        presenter.viewController = spy
        
        presenter.presentError()
        
        #expect(spy.viewModels == [.error(message: ProductListPresenter.loadErrorMessage)])
    }
}
