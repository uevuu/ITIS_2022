//
//  LoginPresenterTests.swift
//  OnlineShopTests
//
//  Created by Teacher on 25.02.2023.
//

import XCTest
@testable import OnlineShop

final class CatalogServiceTests: XCTestCase {
    @MainActor
    override func setUp() {
        catalogService = MockCatalogService()
    }

    var catalogService: MockCatalogService!
 
    func testObtainProducts() async {
        let result = try! await catalogService.obtainProducts()
        XCTAssertTrue(!result.isEmpty)
    }
}
