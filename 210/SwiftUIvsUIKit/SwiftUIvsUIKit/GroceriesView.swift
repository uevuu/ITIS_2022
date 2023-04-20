//
//  GroceriesView.swift
//  SwiftUIvsUIKit
//
//  Created by Teacher on 15.04.2023.
//

import SwiftUI

struct Grocery: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
}

struct GroceriesView: View {
    var groceries: [Grocery]

    @State
    var selectedGrocery: Grocery?

    var body: some View {
        VStack {
            List(groceries, id: \.self, selection: $selectedGrocery) { grocery in
                Text(grocery.name)
            }

            if let selectedGrocery {
                SwiftUIGroceryView(grocery: selectedGrocery)
            }
        }
    }
}

struct GroceriesView_Previews: PreviewProvider {
    static var previews: some View {
        GroceriesView(
            groceries: [
                .init(name: "Water"),
                .init(name: "Bread"),
            ]
        )
    }
}
