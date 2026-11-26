import Foundation

protocol ProductListBusinessLogic {
    func loadProducts() async
    func selectProduct(at index: Int)
}

final class ProductListInteractor: ProductListBusinessLogic {
    private let presenter: ProductListPresentationLogic
    private let service: ProductServiceProtocol
    private var isLoading = false
    
    private let router: ProductListRoutingLogic
    private var products: [Product] = []
    
    init(presenter: ProductListPresentationLogic, service: ProductServiceProtocol, router: ProductListRoutingLogic) {
        self.presenter = presenter
        self.service = service
        self.router = router
    }
    
    func loadProducts() async {
        guard !isLoading else { return }
        isLoading = true
        defer { isLoading = false }

        presenter.presentLoading()

        do {
            let products = try await service.fetchProducts()
            self.products = products
            let response = ProductList.Response(products: products)
            presenter.presentProducts(response: response)
        } catch {
            presenter.presentError()
        }
    }
    
    func selectProduct(at index: Int) {
        guard products.indices.contains(index) else { return }
        router.routeToProductDetail(product: products[index])
    }

}
