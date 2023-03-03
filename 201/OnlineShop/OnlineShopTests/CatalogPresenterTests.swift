//
//  OnlineShopTests.swift
//  OnlineShopTests
//
//  Created by nikita on 03.03.2023.
//

import XCTest
@testable import OnlineShop

final class CatalogPresenterTests: XCTestCase {

    override func setUp() {
        catatalogService = MockCatalogService()
        catalogView = MockCatalogView()
        presenter = CatalogPresenter()
        presenter.view = catalogView as
    }
    
    var catatalogService: MockCatalogService!
    var catalogView: CatalogView!
    var presenter: CatalogPresenter!
    

}
