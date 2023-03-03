@testable import OnlineShop

class MockCatalogView: CatalogView {
    
    var productsIsLoad = false
    var products = [Product]()
    
    func showProducts(_ products: [OnlineShop.Product]) {
        self.products = products
        productsIsLoad = true
    }
}
