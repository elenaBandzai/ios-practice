import Foundation

protocol ProductListDisplayLogic: AnyObject {
    func display(viewModel: ProductList.ViewModel)
}

protocol ProductListPresentationLogic {
    func presentLoading()
    func presentError()
    func presentProducts(response: ProductList.Response)
}

final class ProductListPresenter: ProductListPresentationLogic {
    weak var viewController: ProductListDisplayLogic?
    private let priceFormatter: PriceFormatter

    init(priceFormatter: PriceFormatter = PriceFormatter()) {
        self.priceFormatter = priceFormatter
    }
    
    func presentProducts(response: ProductList.Response) {
        let displayedProducts = response.products.map { product in
            ProductList.DisplayedProduct(
                title: product.title,
                price: priceFormatter.string(from: product.price),
                imageURL: product.thumbnail
            )
        }

        viewController?.display(viewModel: .loaded(displayedProducts))
    }
    
    func presentLoading() {
        viewController?.display(viewModel: .loading)
    }
    
    func presentError() {
        let message = "Couldn't load products. Check your connection and try again."
        viewController?.display(viewModel: .error(message: message))
    }
}
