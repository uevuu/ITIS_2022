import UIKit

let dateFormat = "yyyy-MM-dd-HH-mm-ss"
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = dateFormat

let date = Date()
let dateString = dateFormatter.string(from: date)
print(dateString)
