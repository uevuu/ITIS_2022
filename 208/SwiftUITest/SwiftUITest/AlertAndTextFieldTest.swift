//
//  AlertAndTextFieldTest.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

struct TextInputWithAlertView: View {
    @State
    var login: String = ""

    @State
    var showAlert: Bool = false

    var body: some View {
        VStack {
            TextField("Login", text: $login)
                .textFieldStyle(.roundedBorder)

            Button("Submit") {
                showAlert = true
            }
        }
        .padding(.horizontal)
        .alert("You successfully logged in, \(login.isEmpty ? "some user" : login)", isPresented: $showAlert) {
            Button("Clear") {
                login = ""
            }
            Button("OK") {}
        }
    }
}

struct TextInputWithAlertView_Previews: PreviewProvider {
    static var previews: some View {
        TextInputWithAlertView()
    }
}
