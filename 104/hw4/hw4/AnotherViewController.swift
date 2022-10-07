import UIKit

class AnotherViewController: UIViewController {

    @IBOutlet weak var pageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Catalog"
        pageLabel.text = "Page: \(Int((navigationController?.viewControllers.count)!) - 1)"
    }
    
    @IBAction func tapToNext(_ sender: Any) {
        let anotherVC: AnotherViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AnotherViewController") as! AnotherViewController
        navigationController?.pushViewController(anotherVC, animated: true)
    }
}
