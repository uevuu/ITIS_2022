import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var SignInButton: UIButton!
    let currUser = User(name: "Nikita", password: "123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func SignIn(_ sender: Any) {
        if usernameTextField.text != currUser.name || passwordTextField.text != currUser.password{
            let alert = UIAlertController(title: "Error", message: "Wrong username or password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }else{
            let tabBarController: MainTabBarController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController
            
            let navVC = tabBarController.viewControllers![0] as! UINavigationController
            let homeVC = navVC.topViewController as! HomeViewController
            homeVC.userName = usernameTextField.text!
        
            let logOutVC = tabBarController.viewControllers![1] as! LogOutViewController
            logOutVC.userName = usernameTextField.text!
            
            tabBarController.modalPresentationStyle = .fullScreen
            present(tabBarController, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usernameTextField.text = nil
        passwordTextField.text = nil
    }
}

class User{
    
    let name: String
    let password: String
    
    init(name: String, password: String) {
        self.name = name
        self.password = password
    }
}
 
