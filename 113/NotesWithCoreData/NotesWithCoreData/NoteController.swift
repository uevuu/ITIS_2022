//
//  NoteController.swift
//  UserDefaultsTest
//
//  Created by Teacher on 26.11.2022.
//

import UIKit

class NoteController: UIViewController {
    @IBOutlet
    private var textField: UITextField!

    @IBOutlet
    private var textView: UITextView!

    private var completion: (String, String) -> Void = { _, _ in }

    func setup(
        with title: String, content: String,
        completion: @escaping (String, String) -> Void
    ) {
        textField.text = title
        textView.text = content
        self.completion = completion
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        textView.layer.borderColor = UIColor.systemGray3.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 12
    }

    @IBAction
    private func doneTap() {
        guard let title = textField.text, let content = textView.text else {
            print("Could not get note contents")
            return
        }

        completion(title, content)
    }
}
