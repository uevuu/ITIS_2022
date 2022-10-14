import UIKit


class LogOutViewController: UIViewController {
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var logOutButton: UIButton!

    
    var userName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameLabel.text = "Bye, \(userName)"
        setUpConstraints()
    }
    
    @IBAction func tapToLogOut(_ sender: Any) {
        tabBarController?.dismiss(animated: true)
    }
    
    private func setUpConstraints(){
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 70),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -70),
            logOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 145),
            logOutButton.heightAnchor.constraint(equalToConstant: 100),
            userNameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            userNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
