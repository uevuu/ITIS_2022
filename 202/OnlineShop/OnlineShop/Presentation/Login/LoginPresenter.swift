//
//  LoginPresenter.swift
//  OnlineShop
//
//  Created by Teacher on 11.02.2023.
//

import UIKit

class LoginPresenter {
    init(
        authorizationService: AuthorizationService,
        view: LoginViewController,
        confirmSignIn: @escaping () -> Void
    ) {
        self.authorizationService = authorizationService
        self.view = view
        self.confirmSignIn = confirmSignIn
    }

    private var authorizationService: AuthorizationService!
    private weak var view: LoginViewController?
    private var confirmSignIn: () -> Void = {}

    @MainActor
    func logIn(login: String, password: String) {
        view?.showLoader()
        Task {
            do {
                try await authorizationService.signIn(login: login, password: password)
                view?.hideLoader()
            } catch AuthorizationError.confirmationRequired {
                confirmSignIn()
                view?.hideLoader()
            } catch {
                view?.show(error: error)
                view?.hideLoader()
            }
        }
    }
}
