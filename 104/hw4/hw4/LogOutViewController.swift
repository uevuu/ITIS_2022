import UIKit


class LogOutViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "Bye, \(userName)"
    }
    
    @IBAction func tapToLogOut(_ sender: Any) {
        tabBarController?.dismiss(animated: true)
    }
}
