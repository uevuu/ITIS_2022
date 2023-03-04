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

     func testLoadCatalog() async  {
         await presenter.loadCatalog()
         XCTAssertTrue(catalogView.isReloaded)
     }
 }
