import UIKit

class imageViewController: UIViewController {

    @IBOutlet weak var animaImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        animaImage.image = UIImage(named: String(Int.random(in: 1...3)))
        setUpConstraints()
    }
    
    private func setUpConstraints(){
        animaImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animaImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animaImage.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            animaImage.widthAnchor.constraint(equalToConstant: 400),
            animaImage.heightAnchor.constraint(equalToConstant: 700)
        ])
    }
}
