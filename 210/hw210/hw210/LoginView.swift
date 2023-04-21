//
//  LoginView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct LoginView: View {
    
    @State private var username = ""
    @State private var password = ""
    @State private var showingAlert = false
    @State private var isLogin = false

    var body: some View {
        VStack {
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(8)

            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
            
            Button(action: signIn ) {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
            }
            Spacer()
        }
        .padding()
        .background(Color.gray)
        .alert("Wrong username or password", isPresented: $showingAlert) {
            Button("Ok") {
            }
        }
        .fullScreenCover(isPresented: $isLogin) {
            ContentView(isLogin: $isLogin)
        }
    }

    func signIn() {
        if username == "Nikita" && password == "123" {
            isLogin = true
            username = ""
            password = ""
        } else {
            showingAlert = true
        }
    }
}

