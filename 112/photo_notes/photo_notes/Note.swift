import UIKit

enum noteType: String, Codable{
    case textNote = "textNote"
    case photoNote = "photoNote"
}
struct Note: Codable{
    var type: noteType
    var title: String
    var info: String?
    var createData: String
}

var my_note = Note(type: .textNote, title: "String", info: "info", createData: "12/12/2022")
