//
//  BindingsView.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

struct CheckMarkView: View {
    @Binding
    var isEnabled: Bool

    func imageName() -> String {
        isEnabled ? "checkmark.square" : "square"
    }

    var body: some View {
        Image(systemName: imageName())
            .resizable()
            .frame(width: 50, height: 50)
            .onTapGesture {
                isEnabled.toggle()
            }
    }
}

struct ColoredText: View {
    let text: String

    @State
    var isEnabled: Bool = true

    var body: some View {
        HStack {
            CheckMarkView(isEnabled: $isEnabled)

            Text(text)
                .foregroundColor(isEnabled ? .accentColor : .gray)
                .padding()
                .font(.largeTitle)
        }
    }
}

struct ColoredText_Previews:
    PreviewProvider {
    @State
    static var isEnabled: Bool = false

    static var previews: some View {
        CheckMarkView(isEnabled: $isEnabled)
        ColoredText(text: "Hello")
    }
}
