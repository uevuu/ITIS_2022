//
//  ServiceLocator.swift
//  OnlineShop
//
//  Created by Teacher on 18.02.2023.
//

import Foundation

class ServiceLocator {
    private var resolvers: [String: () -> Any] = [:]

    func register<T>(_ resolver: @escaping () -> T) {
        let typeString = String(describing: T.self)
        resolvers[typeString] = resolver
    }

    func resolve<T>() -> T {
        let typeString = String(describing: T.self)
        guard
            let resolver = resolvers[typeString],
            let resolved = resolver() as? T
        else {
            fatalError("Could not resolve type: \(typeString)")
        }

        return resolved
    }
}
