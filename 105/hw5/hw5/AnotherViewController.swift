import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var pageLabel: UILabel!

    @IBOutlet weak var browseCatalogButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Catalog"
        pageLabel.text = "Page: \(Int((navigationController?.viewControllers.count)!) - 1)"
        setUpConstraints()
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        let anotherVC: AnotherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnotherViewController") as! AnotherViewController
        navigationController?.pushViewController(anotherVC, animated: true)
    }
    
    private func setUpConstraints(){
        pageLabel.translatesAutoresizingMaskIntoConstraints = false
        browseCatalogButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            browseCatalogButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            browseCatalogButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            browseCatalogButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            browseCatalogButton.heightAnchor.constraint(equalToConstant: 100),
            pageLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            pageLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
