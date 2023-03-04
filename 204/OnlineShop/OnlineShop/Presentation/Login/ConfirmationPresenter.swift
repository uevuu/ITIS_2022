//
//  ConfirmationPresenter.swift
//  OnlineShop
//
//  Created by Teacher on 18.02.2023.
//

import Foundation
import Macaroni

class ConfirmationPresenter {
    @Injected
    var authorizationService: AuthorizationService

    func confirm() {
        Task {
            await authorizationService.confirmSignIn()
        }
    }
}
