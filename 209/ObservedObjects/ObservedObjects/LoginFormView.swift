//
//  LoginFormView.swift
//  ObservedObjects
//
//  Created by Teacher on 08.04.2023.
//

import SwiftUI
import Combine

class RandomTextGenerator {
    static let shared = RandomTextGenerator()

    private var randomTextSubject: CurrentValueSubject<String, Never> = .init("")

    init() {
        generate()
    }

    private func generate() {
        randomTextSubject.send(String(Int.random(in: 40...43)))
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in
            generate()
        }
    }

    var randomTextPublisher: AnyPublisher<String, Never> {
        randomTextSubject.eraseToAnyPublisher()
    }
}

/*
@propertyWrapper
struct Environment2<T> {
    private let keyPath: KeyPath<EnvironmentValues, T>

    init(_ keyPath: KeyPath<EnvironmentValues, T>) {
        self.keyPath = keyPath
    }

    var wrappedValue: T {
        fatalError()
    }
}
*/

private var _isEnabled = false

extension EnvironmentValues {
    var isEnabled: Bool {
        get { _isEnabled }
        set { _isEnabled = newValue }
    }
}

class LoginFormViewModel: ObservableObject {
    @Published
    var login: String = ""
    @Published
    var password: String = ""
    @Published
    var showAlert: Bool = false

    var completed: () -> Void = {}

    var randomText: String = "42"

    @Published
    var randomText2: String = ""

    private var cancellables: Set<AnyCancellable> = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [self] in
            randomText = "43"
            objectWillChange.send()
        }

        RandomTextGenerator.shared.randomTextPublisher
            .assign(to: \.randomText2, on: self)
            .store(in: &cancellables)
    }

    func submit() {
        if login == "123" && password == "456" {
            completed()
        } else {
            showAlert = true
        }
    }
}

struct LoginFormView: View {
    @Environment(\.colorScheme)
    var colorScheme // : ColorScheme

    @Environment(\.isEnabled)
    var isEnabled

    @ObservedObject
    private var viewModel: LoginFormViewModel

    @EnvironmentObject
    private var usernameObject: UsernameObject

    init(viewModel: LoginFormViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            Text(viewModel.randomText)
                .font(.largeTitle)
            Text(viewModel.randomText2)
                .font(.largeTitle)
            TextField("Username", text: $usernameObject.username)
                .textFieldStyle(.roundedBorder)
            TextField("Login", text: $viewModel.login)
                .textFieldStyle(.roundedBorder)
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)
            Button("Submit") {
                viewModel.submit()
            }
            .foregroundColor(
                colorScheme == .light
                    ? .indigo
                    : .purple
            )
        }
        .padding()
        .alert("Log in", isPresented: $viewModel.showAlert) {
            Text("OK")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginFormView(viewModel: .init())
            .environmentObject(UsernameObject())
    }
}
