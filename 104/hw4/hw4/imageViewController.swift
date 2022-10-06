import UIKit

class imageViewController: UIViewController {

    @IBOutlet weak var animaImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        animaImage.image = UIImage(named: String(Int.random(in: 1...3)))
    }
}
