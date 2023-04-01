//
//  SwiftUITestApp.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

@main
struct SwiftUITestApp: App {
    @State
    var color = Color.blue

    var body: some Scene {
        WindowGroup {
//            ContentView(showFoo: false)
//            ToggledText(text1: "Hello", text2: "World")
//            VStack {
//                Spacer()
//                ColoredText(text: "Hello", color: $color)
//                Spacer()
//            }
//            .background(color.colorInvert())
            MediumTableView(people: (1...100).map { _ in .init() })
        }
    }
}
