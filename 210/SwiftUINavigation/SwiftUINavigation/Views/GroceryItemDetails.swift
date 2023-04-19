//
//  GroceryItemDetails.swift
//  SwiftUINavigation
//
//  Created by Teacher on 15.04.2023.
//

import SwiftUI

struct GroceryItemDetails: View {
    let groceryItem: GroceryItem

    @EnvironmentObject
    var navigationObject: NavigationObject

    var body: some View {
        VStack {
            Text(groceryItem.name)
            Button("Return to root") {
                navigationObject.path = .init()
            }
        }
    }
}

struct GroceryItemDetails_Previews: PreviewProvider {
    static var previews: some View {
        GroceryItemDetails(
            groceryItem: .init(name: "123")
        )
        .environmentObject(NavigationObject())
    }
}
