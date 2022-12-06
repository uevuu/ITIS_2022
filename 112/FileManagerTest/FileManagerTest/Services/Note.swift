//
//  Note.swift
//  FileManagerTest
//
//  Created by Teacher on 03.12.2022.
//

import Foundation

/**
// Date: "yyyy-MM-dd-HH-mm-ss" (ex.: 2022-12-03-14-12-28)

Documents {
 date-1.json
 date-2.json
 date-3.json
}
*/

struct Note: Codable {
    var title: String
    var content: String
    var creationDate: Date
}
