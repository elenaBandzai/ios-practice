import UIKit
import SwiftUI

protocol ProductListRoutingLogic {
    func routeToProductDetail(product: Product)
}

final class ProductListRouter: ProductListRoutingLogic {
    weak var viewController: UIViewController?

    func routeToProductDetail(product: Product) {
        let detailView = ProductDetailView(product: product)
        let hostingController = UIHostingController(rootView: detailView)
        viewController?.navigationController?.pushViewController(hostingController, animated: true)
    }
}
