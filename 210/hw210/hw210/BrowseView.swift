//
//  BrowseView.swift
//  hw210
//
//  Created by Nikita Marin on 20.04.2023.
//

import SwiftUI

struct BrowseView: View {
    let pageNumber: Int
    var body: some View {
        NavigationLink(destination: BrowseView(pageNumber: pageNumber + 1)) {
            Text("Browse catalog")
                .padding()
                .background(.white)
                .cornerRadius(8)
                .foregroundColor(.gray)
                .padding()
        }
        .navigationTitle("Catalog, Page: \(pageNumber)")
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
    }
}
