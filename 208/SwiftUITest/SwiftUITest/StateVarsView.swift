//
//  StateVarsView.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

struct ToggledText: View {
    let text1: String
    let text2: String

    @State
    var showText1: Bool = true

    var body: some View {
        Group {
            if showText1 {
                Text(text1)
            } else {
                Text(text2)
            }
        }
        .frame(minWidth: 100, minHeight: 100)
        .foregroundColor(.red)
        .padding()
        .font(.largeTitle)
        .onTapGesture {
            showText1.toggle()
        }
    }
}

struct ToggledText_Previews: PreviewProvider {
    static var previews: some View {
        ToggledText(text1: "Hello", text2: "World")
    }
}
