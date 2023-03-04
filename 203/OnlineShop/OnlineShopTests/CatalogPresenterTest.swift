//
//  LoginPresenterTests.swift
//  OnlineShopTests
//
//  Created by Teacher on 25.02.2023.
//

import XCTest
@testable import OnlineShop

final class CatalogPresenterTest: XCTestCase {
    @MainActor
    override func setUp() {
        catalogService = MockCatalogService()
        catalogView = MockCatalogView()
        presenter = CatalogPresenter()
        presenter.view = catalogView
    }

    var catalogService: MockCatalogService!
    var catalogView: MockCatalogView!
    var presenter: CatalogPresenter!
 
    func testObtainProducts() async {
        let result = try! await catalogService.obtainProducts()
        XCTAssertTrue(!result.isEmpty)
    }
    
//    func testLoadCatalog() async  {
//        await presenter.loadCatalog()
//        let result = await catalogView.isReloaded
//        XCTAssertTrue(result)
//    }
}
