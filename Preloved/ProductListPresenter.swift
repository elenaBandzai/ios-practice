import Foundation

protocol ProductListDisplayLogic: AnyObject {
    func display(viewModel: ProductList.ViewModel)
}

protocol ProductListPresentationLogic {
    func presentLoading()
    func presentProducts(response: ProductList.Response)
}

final class ProductListPresenter: ProductListPresentationLogic {
    weak var viewController: ProductListDisplayLogic?

    func presentProducts(response: ProductList.Response) {
        let displayedProducts = response.products.map { product in
            ProductList.DisplayedProduct(
                title: product.title,
                price: formatPrice(product.price)
            )
        }

        viewController?.display(viewModel: .loaded(displayedProducts))
    }
    
    func presentLoading() {
        viewController?.display(viewModel: .loading)
    }
    
    private func formatPrice(_ price: Double) -> String {
        price.formatted(.currency(code: "EUR"))
    }
}
