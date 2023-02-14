import UIKit

protocol LoginView {}
protocol LoginPresenter {
    func logIn(username: String, password: String)
}

class LoginVC: UIViewController, LoginView {
    var presenter: LoginPresenter!

    @objc func loginTap() {
        presenter.logIn(username: "123", password: "123")
    }
}

enum AuthorizationStatus {
    case authorized
    case needVerification
}

protocol AuthService {
    func logIn(username: String, password: String, completion: @escaping (Result<AuthorizationStatus, Error>) -> Void)
}

class LoginPresenterImplementation: LoginPresenter {
    var view: LoginView!
    var authService: AuthService!

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
        let presenter = LoginPresenterImplementation()
        presenter.didFinish = finish
        presenter.requestVerification = { [weak self] in
            guard let self else { return }

            self.navigationController?
                .pushViewController(
                    self.codeVerification(), animated: true
                )
        }
        authController.presenter = presenter
        presenter.view = authController
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
