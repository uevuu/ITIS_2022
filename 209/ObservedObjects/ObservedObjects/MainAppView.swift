//
//  MainAppView.swift
//  ObservedObjects
//
//  Created by Teacher on 08.04.2023.
//

import SwiftUI

class MainAppViewModel: ObservableObject {
    enum AuthorizationState {
        case authorized
        case unauthorized
    }

    @Published
    var authorizationState: AuthorizationState = .unauthorized

    func loginForm() -> some View {
        let viewModel = LoginFormViewModel()
        viewModel.completed = { [weak self] in
            self?.authorizationState = .authorized
            self?.objectWillChange.send()
        }
        return LoginFormView(viewModel: viewModel)
    }

    func appContentView() -> some View {
        AppContentView()
    }
}

class UsernameObject: ObservableObject {
    @Published
    var username: String = ""

    init(username: String = "") {
        self.username = username
    }
}

struct MainAppView: View {
    @ObservedObject
    private var viewModel: MainAppViewModel = .init()

    @StateObject
    var usernameObject: UsernameObject = .init()

    var body: some View {
        Group {
            switch viewModel.authorizationState {
                case .authorized:
                    viewModel.appContentView()
                case .unauthorized:
                    viewModel.loginForm()
            }
        }
        .environmentObject(usernameObject)
    }
}

struct MainAppView_Previews: PreviewProvider {
    static var previews: some View {
        MainAppView()
    }
}
