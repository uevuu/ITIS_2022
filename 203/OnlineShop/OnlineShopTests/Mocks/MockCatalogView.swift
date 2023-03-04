import Foundation
@testable import OnlineShop

class MockCatalogView: CatalogView {
    
    var products: [Product] = []
    var isReloaded = false

    func showProducts(_ products: [OnlineShop.Product]) {
        self.products = products
        isReloaded = true
    }
}
