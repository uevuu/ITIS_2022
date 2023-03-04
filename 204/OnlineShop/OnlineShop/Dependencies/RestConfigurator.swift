//
//  Configurator.swift
//  OnlineShop
//
//  Created by Teacher on 18.02.2023.
//

import Foundation
import Macaroni
import ImageLoader

class RestConfigurator {
    func configure() {
        Macaroni.logger = DisabledMacaroniLogger()
        let container = Container()
        Container.lookupPolicy = .singleton(container)
        let authorizationService = RestAuthorizationService()
        container.register { () -> AuthorizationService in
            authorizationService
        }
        container.register { () -> ImageLoader in
            URLImageLoader()
        }
    }
}
