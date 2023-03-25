//
//  AppCoordinator.swift
//  DeepLinksTest
//
//  Created by Teacher on 25.03.2023.
//

import UIKit

extension URL {
    public var queryItems: [URLQueryItem]? {
        let components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        return components?.queryItems
    }
}

enum DeepLink {
    case product(id: String)
    case checkout
    case order

    init?(url: URL) {
        if url.absoluteString.starts(with: "dltest://product"), let query = url.queryItems, let productId = query.first(where: { $0.name == "id" })?.value {
            self = .product(id: productId)
        } else {
            return nil
        }
    }
}

class AppCoordinator {
    static let shared = AppCoordinator()

    func handle(url: URL) {
        guard let deeplink = DeepLink(url: url) else { return }

        switch deeplink {
            case .product(let productId):
//                CatalogCoordinator().openProduct(productId: productId)
                print("Opened product with id: \(productId)")
            default:
                break
        }
    }
}
