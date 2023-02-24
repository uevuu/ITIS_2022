//
//  Configurator.swift
//  OnlineShop
//
//  Created by Teacher on 18.02.2023.
//

import Foundation

class RestConfigurator {
    func configure() -> ServiceLocator {
        let serviceLocator = ServiceLocator()
        let authorizationService = RestAuthorizationService()
        serviceLocator.register { () -> AuthorizationService in
            authorizationService
        }
        return serviceLocator
    }
}
