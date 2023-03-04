//
//  Configurator.swift
//  OnlineShop
//
//  Created by Teacher on 18.02.2023.
//

import Foundation
import Macaroni
import ImageLoader

class MockConfigurator {
    func configure() {
        Macaroni.logger = DisabledMacaroniLogger()
        let container = Container()
        Container.lookupPolicy = .singleton(container)
        let authorizationService = MockAuthorizationService()
        container.register { () -> AuthorizationService in
            authorizationService
        }
        container.register { () -> ImageLoader in
            MockImageLoader()
        }
    }
}
