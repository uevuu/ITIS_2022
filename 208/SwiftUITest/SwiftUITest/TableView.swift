//
//  TableView.swift
//  SwiftUITest
//
//  Created by Teacher on 01.04.2023.
//

import SwiftUI

struct CustomHeader: View {
    let section: Int

    var body: some View {
        Button {
            print("Section \(section) tap")
        } label: {
            Text("<Section \(section)>")
        }
    }
}

struct SimpleTableView: View {
    var body: some View {
        List {
            Section {
                Text("Hello")
            } header: {
                CustomHeader(section: 1)
            }

            Section {
                Text("World")
                    .background(Color.blue.opacity(0.3))
                    .listRowBackground(Color.gray)
                Image(systemName: "person.fill")
            } header: {
                CustomHeader(section: 2)
            }

            Section {
                ForEach(0 ..< 10) { index in
                    Text("Row \(index)")
                }
            } header: {
                CustomHeader(section: 3)
            } footer: {
                CustomHeader(section: 4)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct Person: Identifiable {
    let id: String = UUID().uuidString
    let name: String

    init() {
        self.name = "Human \(id.prefix(6))"
    }
}

struct MediumTableView: View {
    @State
    var people: [Person]

    var body: some View {
        List($people, id: \.id, editActions: .move) { $person in
            Text(person.name)
        }
    }
}

struct EasyCollectionView: View {
    let people: [Person]

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Section {
                    ForEach(people) { person in
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 12)
                                .stroke()
                                .padding(.all, 1)

                            Text(person.name)
                                .padding(.all, 9)
                        }
                    }
                } header: {
                    CustomHeader(section: 0)
                }
            }
        }
        .padding(.horizontal)
    }
}

struct TableView_Previews: PreviewProvider {
    static let people: [Person] = (1...100).map { _ in .init() }

    static var previews: some View {
        SimpleTableView()
        MediumTableView(people: people)
        EasyCollectionView(people: people)
    }
}
