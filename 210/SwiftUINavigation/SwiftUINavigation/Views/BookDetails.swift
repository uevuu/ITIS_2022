//
//  BookDetails.swift
//  SwiftUINavigation
//
//  Created by Teacher on 15.04.2023.
//

import SwiftUI

struct BookDetails: View {
    let book: Book

    var body: some View {
        VStack {
            Text(book.name)
                .font(.largeTitle)
            Text(book.author)
        }
    }
}

struct BookDetails_Previews: PreviewProvider {
    static var previews: some View {
        BookDetails(book: .init(name: "123", author: "123"))
    }
}
