//
//  HomeView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct HomeView: View {
    @State private var showAnimal = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button {
                    showAnimal = true
                } label: {
                    Text("Show image")
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                        .padding()
                }
                NavigationLink(destination: BrowseView(pageNumber: 1)) {
                    Text("Browse catalog")
                        .padding()
                        .background(.white)
                        .cornerRadius(8)
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.gray)
        }.fullScreenCover(isPresented: $showAnimal) {
            ModalAnimalView(showModal: $showAnimal)
        }
    }
}
