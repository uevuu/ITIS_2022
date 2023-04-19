//
//  Book.swift
//  SwiftUINavigation
//
//  Created by Teacher on 15.04.2023.
//

import Foundation

struct Book: Identifiable, Hashable {
    var id: String = UUID().uuidString
    var name: String
    var author: String
}
