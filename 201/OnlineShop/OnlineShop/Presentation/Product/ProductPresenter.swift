import UIKit

class ProductPresenter {
    
    weak var view: ProductViewController?

    func loadProduct(_ product: Product){
        view?.setProduct(product)
    }
    
}
