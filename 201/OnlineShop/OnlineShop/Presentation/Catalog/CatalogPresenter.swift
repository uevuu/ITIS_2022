import UIKit

class CatalogPresenter {
    
    var catalogService: CatalogService = MockCatalogService.shared
    weak var view: CatalogViewController?
    
    @MainActor
    func loadCatalog() {
        Task{
            do {
                let products = try await catalogService.obtainProducts()
                view?.showProducts(products)
            } catch{
                print("error")
            }
        }
    }
    
    @MainActor
    func didSelectProduct(_ product: Product){
        FlowCoordinator.shared.showProduct(product)
    }
}
