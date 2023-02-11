import UIKit

protocol LoginView: AnyObject {}
protocol LoginInteractor {
    func logIn(username: String, password: String)
}
protocol LoginPresenter: AnyObject {
    func logIn(username: String, password: String)
}
protocol LoginRouter {
    func finish()
}

class LoginVC: UIViewController, LoginView {
    var presenter: LoginPresenter!

    @objc func loginTap() {
        presenter.logIn(username: "123", password: "123")
    }
}

class LoginPresenterImplementation: LoginPresenter {
    weak var view: LoginView!
    var interactor: LoginInteractor!
    var router: LoginRouter!

    func logIn(username: String, password: String) {
        interactor.logIn(username: username, password: password)
    }

    func didSignIn() {
        router.finish()
    }
}

class LoginInteractorImplementation: LoginInteractor {
    weak var presenter: LoginPresenter!

    func logIn(username: String, password: String) {
        // ...
        // presenter.didSignIn()...
    }
}

class LoginRouterImplementation: LoginRouter {
    weak var presenter: LoginPresenter!

    func finish() {
        // open other VC
    }
}
