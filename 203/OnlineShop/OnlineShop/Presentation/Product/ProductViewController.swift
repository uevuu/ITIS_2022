import UIKit

class ProductViewController: UIViewController {
    
    var presenter: ProductPresenter!
    let product: Product

    init(pickedProduct: Product) {
        self.product = pickedProduct
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var nameLabel: UILabel = .init()
    private var decriptionLabel: UILabel = .init()
    private var priceLabel: UILabel = .init()
    private var countLabel: UILabel = .init()
    private var typeLabel: UILabel = .init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadProduct(product)
        setConstraints()
        view.backgroundColor = .white
    }
    
    func setConstraints() {
        let stack = UIStackView(arrangedSubviews: [nameLabel, decriptionLabel, priceLabel, countLabel, typeLabel])
        decriptionLabel.numberOfLines = 0
        stack.axis = .vertical
        stack.spacing = 2
        stack.alignment = .leading
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 5),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 5),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -5),
        ])
    }
    func setProduct(_ product: Product) {
        nameLabel.text = product.name
        decriptionLabel.text = "\(product.decription.rawValue)"
        priceLabel.text = "Цена: \(product.price)"
        countLabel.text = "Количество: \(product.count)"
        typeLabel.text = "Тип: \(product.type.rawValue)"
    }
}
