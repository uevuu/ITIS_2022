import UIKit

class HomeViewController: UIViewController {
    
    var userName: String = ""
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = "Hello, \(userName)"
    }
    

    @IBAction func tapToViewImg(_ sender: Any) {
        let ImgVC: imageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageViewController") as! imageViewController
        present(ImgVC, animated: true)
    }
    
    @IBAction func tapToViewCatalog(_ sender: Any) {
        let anotherVC: AnotherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnotherViewController") as! AnotherViewController
        navigationController?.pushViewController(anotherVC, animated: true)
    }
}
