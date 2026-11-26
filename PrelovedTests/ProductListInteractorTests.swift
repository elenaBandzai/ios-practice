import Foundation
import Testing
@testable import Preloved

@MainActor
struct ProductServiceStub: ProductServiceProtocol {
    let result: Result<[Product], any Error>

    func fetchProducts() async throws -> [Product] {
        try result.get()
    }
}

@MainActor
final class PresenterSpy: ProductListPresentationLogic {
    enum Call: Equatable {
        case loading
        case products([Product])
        case error
    }

    var calls: [Call] = []

    func presentLoading() {
        calls.append(.loading)
    }

    func presentProducts(response: ProductList.Response) {
        calls.append(.products(response.products))
    }

    func presentError() {
        calls.append(.error)
    }
}

@MainActor
final class RouterSpy: ProductListRoutingLogic {
    var routedProducts: [Product] = []

    func routeToProductDetail(product: Product) {
        routedProducts.append(product)
    }
}

struct TestError: Error {}

@MainActor
struct ProductListInteractorTests {
    
    @Test func loadProductsPresentsLoadingThenProducts() async {
        let product = Product.sample()
        let presenterSpy = PresenterSpy()
        let interactor = ProductListInteractor(presenter: presenterSpy, service: ProductServiceStub(result: .success([product])), router: RouterSpy())
        
        await interactor.loadProducts()
        
        #expect(presenterSpy.calls == [.loading,.products([product])])
    }
    
    @Test func loadProductsPresentsErrorWhenServiceFails() async {
        let error = TestError()
        let presenterSpy = PresenterSpy()
        let interactor = ProductListInteractor(presenter: presenterSpy, service: ProductServiceStub(result: .failure(error)), router: RouterSpy())
        
        await interactor.loadProducts()
        
        #expect(presenterSpy.calls == [.loading,.error])
    }
    
    @Test func selectProductRoutesToThatProduct() async {
        let jacket = Product.sample(title: "Jacket")
        let boots = Product.sample(title: "Boots")
        let routerSpy = RouterSpy()
        let interactor = ProductListInteractor(presenter: PresenterSpy(), service: ProductServiceStub(result: .success([jacket, boots])), router: routerSpy)
        await interactor.loadProducts()
        
        interactor.selectProduct(at: 1) // tap the second row
        
        #expect(routerSpy.routedProducts == [boots])
    }
    
    @Test func selectProductWithInvalidIndexDoesNotRoute() async {
        let product = Product.sample()
        let routerSpy = RouterSpy()
        let interactor = ProductListInteractor(presenter: PresenterSpy(), service: ProductServiceStub(result: .success([product])), router: routerSpy)
        await interactor.loadProducts()
        
        interactor.selectProduct(at: 1)
        
        #expect(routerSpy.routedProducts == [])
    }
}
