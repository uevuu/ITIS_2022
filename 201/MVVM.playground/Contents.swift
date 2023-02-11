import UIKit

protocol LoginView {}

struct LoginViewState {
    let login: String
    let password: String
}

protocol LoginViewModel: AnyObject {
    var stateUpdated: (LoginViewState) -> Void { get set }
    func logIn(username: String, password: String)
}

class LoginVC: UIViewController, LoginView {
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.stateUpdated = { [weak self] state in
            self?.update(with: state)
        }
    }

    private func update(with state: LoginViewState) {
        // ...
    }

    @objc func loginTap() {
        viewModel.logIn(username: "123", password: "123")
    }
}

enum AuthorizationStatus {
    case authorized
    case needVerification
}

protocol AuthService {
    func logIn(username: String, password: String, completion: @escaping (Result<AuthorizationStatus, Error>) -> Void)
}

class LoginViewModelImplementation: LoginViewModel {
    var authService: AuthService!

    private var state: LoginViewState = .init(login: "", password: "") {
        didSet {
            stateUpdated(state)
        }
    }

    var stateUpdated: (LoginViewState) -> Void = { _ in }

    var didFinish: () -> Void = {}
    var requestVerification: () -> Void = {}

    func logIn(username: String, password: String) {
        authService.logIn(username: username, password: password) { [self] result in
            switch result {
                case .success(let authStatus):
                    // view.present — плохо
                    // потому что получается связаность в коде
                    switch authStatus {
                        case .authorized:
                            didFinish()
                        case .needVerification:
                            requestVerification()
                    }
                case .failure(let error):
                    print(error)
            }
        }
    }
}

class AuthFlowCoordinator {
    var finish: () -> Void = {}
    weak var navigationController: UINavigationController?

    func start() -> UIViewController {
        let authController = LoginVC()
        let viewModel = LoginViewModelImplementation()
        viewModel.didFinish = finish
        viewModel.requestVerification = { [weak self] in
            guard let self else { return }

            self.navigationController?
                .pushViewController(
                    self.codeVerification(), animated: true
                )
        }
        authController.viewModel = viewModel
        let navigationController = UINavigationController(
            rootViewController: authController
        )
        return navigationController
    }

    func codeVerification() -> UIViewController {
        .init()
    }
}

class ShoppingFlowCoordinator {
    func start() -> UIViewController {
        .init()
    }
}

let authFlow = AuthFlowCoordinator()
authFlow.finish = {
    let shoppingFlow = ShoppingFlowCoordinator()
    let shoppingVC = shoppingFlow.start()
    // window.rootViewController = shoppingVC
}
let authVC = authFlow.start()
// window.rootViewController = authVC
