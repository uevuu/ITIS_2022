import UIKit

let jsonString = """
{
    "firstName123": "Amir",
    "floor": 14,
    "race": "human",
    "customEnum": {
        "type": "string",
        "stringValue": "Hello world"
    }
}
"""
guard let data = jsonString.data(using: .utf8) else {
    exit(1)
}

// Codable == Encodable & Decodable
struct CreatureOnTheFloor: Codable {
    enum Race: String, Codable {
        case human
        case martian
    }

    /*
     1. { "string": "Some string" } / { "date": "01.01.2001" }
     2. { "type": "string", "stringValue": "Some string" }
     */

    enum CustomEnum: Codable {
        case string(String)
        case date(Date)

        enum CodingKeys: String, CodingKey {
            case type
            case stringValue
            case date
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeString = try container.decode(String.self, forKey: .type)
            switch typeString {
                case "string":
                    let string = try container.decode(String.self, forKey: .stringValue)
                    self = .string(string)
                case "date":
                    self = .date(.now)
                default:
                    throw DecodingError.keyNotFound(CodingKeys.type, .init(codingPath: [], debugDescription: "123"))
            }
        }

        func encode(to encoder: Encoder) throws {
//            encoder.container(keyedBy: <#T##CodingKey.Protocol#>)
        }
    }

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName123"
        case lastName
        case floor
        case race
        case customEnum
    }

    var firstName: String
    var lastName: String?
    var floor: Int
    var race: Race
    var customEnum: CustomEnum
}

let decoder = JSONDecoder()
// превратит "snake_case" в "snakeCase" (на самом деле camelCase)
// decoder.keyDecodingStrategy = .convertFromSnakeCase
var creature = try decoder.decode(CreatureOnTheFloor.self, from: data)
print(creature)

creature.floor = 0
let encoder = JSONEncoder()
let encodedData = try encoder.encode(creature)
guard let encodedString = String(data: encodedData, encoding: .utf8) else {
    exit(2)
}
print(encodedString)
