import UIKit


class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    let currUser = User(name: "Nikita", password: "123")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpConstraints()
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
    
    private func setUpConstraints(){
        let stackView = UIStackView(arrangedSubviews: [usernameTextField, passwordTextField])
        stackView.axis = .vertical
        stackView.spacing = 10
        signInButton.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 60),
            signInButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            signInButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 100),
            signInButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
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
 
