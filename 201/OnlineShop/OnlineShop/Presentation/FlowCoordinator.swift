
import UIKit

@MainActor
class FlowCoordinator {
  
    weak var navigationController: UINavigationController?
    static let shared: FlowCoordinator = .init()
    var catalogService: CatalogService = MockCatalogService.shared
    
    
    func start() -> UIViewController {
        let catalogVC = CatalogViewController()
        let catalogPresenter = CatalogPresenter()
        catalogVC.presenter = catalogPresenter
        catalogPresenter.view = catalogVC
        navigationController = UINavigationController(rootViewController: catalogVC)
        return navigationController!
        
    }
    
    func showProduct(_ product: Product) {
        let productVC = ProductViewController(pickedProduct: product)
        let catalogPresenter = ProductPresenter()
        productVC.presenter = catalogPresenter
        catalogPresenter.view = productVC
        navigationController?.pushViewController(productVC, animated: true)
    }
}
