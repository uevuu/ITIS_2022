//
//  ProfileView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct ProfileView: View {
    var name: String
    @Binding var isLogin: Bool
    var body: some View {
        VStack {
            Text("Hello, \(name)")
                .font(.title)
                .foregroundColor(.white)
                .padding(.top)
            Spacer()
            Button {
                isLogin = false
            } label: {
                Text("Sign out")
                    .padding()
                    .background(.white)
                    .cornerRadius(8)
                    .foregroundColor(.gray)
                    .padding()
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}
