//
//  ModalAnimalView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct ModalAnimalView: View {
    @Binding var showModal : Bool
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    showModal = false
                } label: {
                    Text("Close")
                        .padding(.leading)
                }
                Spacer()
                Text("Animal image")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)

                
            }
            .padding(.top)
            .foregroundColor(.white)
            
            Spacer()
            
            Image("animal")
                .resizable()
                .scaledToFill()
                .frame(width: 200, height: 300)
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}
