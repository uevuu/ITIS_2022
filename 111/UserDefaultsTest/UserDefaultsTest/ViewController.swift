//
//  ViewController.swift
//  UserDefaultsTest
//
//  Created by Teacher on 26.11.2022.
//

import UIKit

struct Note {
    let title: String
    let content: String

//    func saveToUserDefaults() {
//        UserDefaults.standard.set(title, forKey: "title")
//        UserDefaults.standard.set(content, forKey: "content")
//    }

//    init?() {
//        guard
//            let title = UserDefaults.standard
//                .value(forKey: "title") as? String,
//            let content = UserDefaults.standard.string(forKey: "content")
//        else {
//            return nil
//        }
//
//        self.title = title
//        self.content = content
//    }

//    init(title: String, content: String) {
//        self.title = title
//        self.content = content
//    }
}

class ViewController: UIViewController {
    var notes: [Note] = []

    @IBAction
    private func openNote() {
        let controller: NoteController
            = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(identifier: "NoteController")
        present(controller, animated: true)

        controller.notes = notes
        controller.finished = { notes in
            print("Screen closed with \(notes.count) notes")
            // save notes
            // tableView.reloadData()
        }
    }
}
