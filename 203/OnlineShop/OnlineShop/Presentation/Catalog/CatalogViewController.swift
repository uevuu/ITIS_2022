import UIKit

protocol CatalogView: AnyObject {
    var products: [Product] { get set }
    func showProducts(_ products: [Product])
}
       
class CatalogViewController: UIViewController, CatalogView {
    
    var presenter: CatalogPresenter!
    var products: [Product] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.loadCatalog()
        setup()
        view.backgroundColor = .white
    }
    
    
    func showProducts(_ products: [Product]){
        self.products = products
        tableView.reloadData()
    }
    

}

extension CatalogViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    private func setup(){
        title = "Catalog"
        tabBarItem = .init(
            title: "Catalog",
            image: .init(systemName: "cart"),
            selectedImage: .init(systemName: "cart.fill")
        )
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let product = products[indexPath.row]
        cell?.textLabel?.text = product.name
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        presenter.didSelectProduct(product)
    }
}
