//
//  ContentView.swift
//  SwiftUINavigation
//
//  Created by Teacher on 15.04.2023.
//

import SwiftUI

struct GroceryCell: View {
    let item: GroceryItem

    var body: some View {
        Text(item.name)
    }
}

struct BookCell: View {
    let book: Book

    var body: some View {
        VStack(alignment: .leading) {
            Text(book.name)
            Text(book.author)
                .font(.caption)
        }
    }
}

class NavigationObject: ObservableObject {
    @Published
    var path: NavigationPath = .init()
}

struct ContentView: View {
    var groceryItems: [GroceryItem] = [
        .init(name: "Milk"),
        .init(name: "Eggs"),
        .init(name: "Fish"),
        .init(name: "Chips"),
    ]

    var books: [Book] = [
        .init(name: "War&Peace", author: "Tolstoy"),
        .init(name: "Crime and Punishment", author: "Dostoevsky"),
    ]

    @ObservedObject
    var navigationObject: NavigationObject = .init()

    @State
    var showBottomSheet: Bool = false

    @State
    var showFullScreenModal: Bool = false

    var body: some View {
        TabView {
            NavigationStack(path: $navigationObject.path) {
                List {
                    Section {
                        ForEach(groceryItems) { item in
                            NavigationLink(value: item) {
                                GroceryCell(item: item)
                            }
                        }
                    }

                    Section {
                        ForEach(books) { book in
                            NavigationLink(value: book) {
                                BookCell(book: book)
                            }
                        }
                    }

                    Section("Custom buttons") {
                        Button("Push milk") {
                            navigationObject.path
                                .append(groceryItems[0])
                            navigationObject.path
                                .append(groceryItems[0])
                            navigationObject.path
                                .append(groceryItems[0])
                            navigationObject.path
                                .append(groceryItems[0])
                            navigationObject.path
                                .append(groceryItems[0])
                            navigationObject.path
                                .append(groceryItems[0])
                        }

                        Button("Show modal bottom sheet") {
                            showBottomSheet.toggle()
                        }
                        .sheet(isPresented: $showBottomSheet) {
                            Text("Bottom sheet presented")
                        }

                        Button("Show full screen modal") {
                            showFullScreenModal.toggle()
                        }
                        .fullScreenCover(isPresented: $showFullScreenModal) {
                            VStack {
                                Button("Close") {
                                    showFullScreenModal.toggle()
                                }
                                Text("Full screen modal presented")
                            }
                        }
                    }
                }
                .navigationDestination(for: GroceryItem.self) { groceryItem in
                    GroceryItemDetails(groceryItem: groceryItem)
                }
                .navigationDestination(for: Book.self) { book in
                    BookDetails(book: book)
                }
            }
            .tabItem {
                Label("Content", systemImage: "person.crop.circle.fill")
            }
            .environmentObject(navigationObject)

            Text("123")
                .tabItem {
                    Label("Hello", systemImage: "square.fill")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
