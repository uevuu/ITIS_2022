//
//  LoginPresenterTests.swift
//  OnlineShopTests
//
//  Created by Teacher on 25.02.2023.
//

import XCTest
@testable import OnlineShop

final class LoginPresenterTests: XCTestCase {
    @MainActor
    override func setUp() {
        authorizationService = MockAuthorizationService()
        loginView = MockLoginView()
        confirmSignIn = {}

        presenter = LoginPresenter(
            authorizationService: authorizationService,
            view: loginView,
            confirmSignIn: confirmSignIn
        )
    }

    var authorizationService: MockAuthorizationService!
    var loginView: MockLoginView!
    var confirmSignIn: () -> Void = {}

    var presenter: LoginPresenter!

    func testShowLoaderIsCalled() async {
        // Act
        await presenter.logIn(login: "123", password: "123")

        // Assert
        let result = await loginView.showLoaderIsCalled
        XCTAssertTrue(result)
    }

    func testLogInIsCalled() async {
        await presenter.logIn(login: "123", password: "456")

        let (login, password) = authorizationService.signedInCredentials ?? ("", "")

        XCTAssertEqual(login, "123")
        XCTAssertEqual(password, "456")
    }
    
    func testhideLoaderIsCalled() async {
        await presenter.logIn(login: "123", password: "123")
        let result = await loginView.hideLoaderIsCalled
        XCTAssertTrue(result)
    }
    
    func testShowError() async {
        
        await presenter.logIn(login: "Nikita", password: "11-104")
        let result = await loginView.errorShown
        XCTAssertEqual(result as! AuthorizationError, AuthorizationError.unauthorized)        
    }
}
