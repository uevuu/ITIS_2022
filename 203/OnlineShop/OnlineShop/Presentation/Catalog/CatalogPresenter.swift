import UIKit

class CatalogPresenter {
    
    var catalogService: CatalogService = MockCatalogService.shared
    weak var view: CatalogView?
    
    @MainActor
    func loadCatalog() {
        Task{
            do {
                print("do in presenter")
                let products = try await catalogService.obtainProducts()
                view?.showProducts(products)
                print("view.products = ... (in presenter)")
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
