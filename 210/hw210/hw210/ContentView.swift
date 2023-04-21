//
//  ContentView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct ContentView: View {
    @Binding var isLogin: Bool
    
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            ProfileView(name: "Nikita", isLogin: $isLogin)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}


