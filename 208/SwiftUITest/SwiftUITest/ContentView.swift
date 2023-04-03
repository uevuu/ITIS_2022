//
//  ContentView.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

extension View {
    func myPadding(color: Color = .clear) -> some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                self
                Spacer()
            }
            Spacer()
        }
        .background(color)
    }
}

struct ContentView: View {
    let showFoo: Bool

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)

            Text("Hello, world!")
                .foregroundColor(.primary)

            HStack {
                if showFoo {
                    Text("Foo")
                } else {
                    Text("Bar")
                        .background(Color.blue)
                        .myPadding(color: .brown)
                }
                Text("123")
            }

            Button {
                print("Hello")
            } label: {
                HStack {
                    Text("12345")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView(showFoo: false)
                .frame(width: 200, height: 300)
            
            ContentView(showFoo: true)
                .frame(width: 500, height: 200)
        }
    }
}
