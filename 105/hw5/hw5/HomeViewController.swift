import UIKit

class HomeViewController: UIViewController {
    
    var userName: String = ""
    @IBOutlet weak var browseCatalogButton: UIButton!
    @IBOutlet weak var animalImageButton: UIButton!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = "Hello, \(userName)"
        setUpConstraints()
    }
    

    @IBAction func tapToViewImg(_ sender: Any) {
        let ImgVC: imageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! imageViewController
        present(ImgVC, animated: true)
    }
    
    @IBAction func tapToViewCatalog(_ sender: Any) {
        let anotherVC: AnotherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnotherViewController") as! AnotherViewController
        navigationController?.pushViewController(anotherVC, animated: true)
    }
    
    private func setUpConstraints(){
        let stackView = UIStackView(arrangedSubviews: [browseCatalogButton, animalImageButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            browseCatalogButton.heightAnchor.constraint(equalToConstant: 100),
            animalImageButton.heightAnchor.constraint(equalToConstant: 100),
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}

