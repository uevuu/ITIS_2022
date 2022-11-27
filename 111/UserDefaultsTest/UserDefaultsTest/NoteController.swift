//
//  NoteController.swift
//  UserDefaultsTest
//
//  Created by Teacher on 26.11.2022.
//

import UIKit

@propertyWrapper
struct Capitalized {
    var wrappedValue: String? {
        didSet {
            wrappedValue = wrappedValue?.capitalized
        }
    }
}

protocol UserDefaultable {
    var storedValue: Any { get }
    init?(storedValue: Any?)
}

extension String: UserDefaultable {
    var storedValue: Any { self }

    init?(storedValue: Any?) {
        if let string = storedValue as? String {
            self = string
        } else {
            return nil
        }
    }
}
extension Int: UserDefaultable {
    var storedValue: Any { self }

    init?(storedValue: Any?) {
        if let int = storedValue as? Int {
            self = int
        } else {
            return nil
        }
    }
}
extension Note: UserDefaultable {
    var storedValue: Any {
        [
            "title": title,
            "content": content
        ]
    }

    init?(storedValue: Any?) {
        guard
            let dictionary = storedValue as? [String: String],
            let title = dictionary["title"],
            let content = dictionary["content"]
        else { return nil }

        self.title = title
        self.content = content
    }
}

@propertyWrapper
struct UserDefault<T: UserDefaultable> {
    var wrappedValue: T? {
        get {
            T(storedValue: UserDefaults.standard.value(forKey: key))
        }
        set {
            if let newValue {
                UserDefaults.standard.set(newValue.storedValue, forKey: key)
            } else {
                UserDefaults.standard.removeObject(forKey: key)
            }
        }
    }

    private let key: String

    init(key: String) {
        self.key = key
    }
}

class NoteController: UIViewController {
    @IBOutlet
    private var textField: UITextField!

    /*
     {
        "title": "string",
        "content": "string",
        "openCount": 0,
        "note": {
            "title": "string",
            "content": "string"
        },
        "notes": [
            {
                "title": "string",
                "content": "string"
            },
            {
                "title": "string",
                "content": "string"
            },
        ]
     }
     */

    @UserDefault(key: "title")
    private var noteTitle: String?

    @UserDefault(key: "content")
    private var noteContent: String?

    @UserDefault(key: "openCount")
    private var openCount: Int?

    @UserDefault(key: "note")
    private var note: Note?

    @IBOutlet
    private var textView: UITextView!

    @Capitalized
    var myString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

//        myString = "abc"
//        print(String(describing: myString))
//
//        print(String(describing: noteTitle))
//        print(String(describing: noteContent))

        if let openCount {
            self.openCount = openCount + 1
        } else {
            self.openCount = 1
        }
        print("Opened this screen \(openCount ?? 0) times :)")

        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 12

        if let note {
            textField.text = note.title
            textView.text = note.content
        }
    }

    var notes: [Note] = []
    var finished: ([Note]) -> Void = { _ in }

    @IBAction
    private func doneTap() {
        finished(notes)
        dismiss(animated: true)
        guard let title = textField.text, let content = textView.text else { return }

//        let note = Note(title: title, content: content)
//        note.saveToUserDefaults()

//        noteTitle = title
//        noteContent = content

        note = Note(title: title, content: content)
    }
}
