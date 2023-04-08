//
//  AppContentView.swift
//  ObservedObjects
//
//  Created by Teacher on 08.04.2023.
//

import SwiftUI

struct AppContentView: View {
    @EnvironmentObject
    private var usernameObject: UsernameObject

    var body: some View {
        Text("Hello, \(usernameObject.username)!")
            .font(.largeTitle)
    }
}

struct AppContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppContentView()
            .environmentObject(UsernameObject(username: "world"))
    }
}
