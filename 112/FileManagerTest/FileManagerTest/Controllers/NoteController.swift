//
//  NoteController.swift
//  UserDefaultsTest
//
//  Created by Teacher on 26.11.2022.
//

import UIKit

class NoteController: UIViewController {
    var noteService: NoteService!

    @IBOutlet
    private var textField: UITextField!

    var note: Note?

    @IBOutlet
    private var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 12

        if let note {
            textField.text = note.title
            textView.text = note.content
        }
    }

    @IBAction
    private func doneTap() {
        guard let title = textField.text, let content = textView.text else { return }

        let note = Note(title: title, content: content, creationDate: Date())
        do {
            try noteService.save(note: note)
            dismiss(animated: true)
        } catch {
            print(error)
        }
    }
}
