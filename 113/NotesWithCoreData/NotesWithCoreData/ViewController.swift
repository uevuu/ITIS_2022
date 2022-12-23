//
//  ViewController.swift
//  NotesWithCoreData
//
//  Created by Teacher on 10.12.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet
    private var tableView: UITableView!

    private func createNoteController() -> NoteController {
        guard
            let noteController: NoteController = storyboard?
                .instantiateViewController(identifier: "NoteController")
        else {
            fatalError("Could not get storyboard")
        }

        return noteController
    }

    @IBAction
    private func newNote() {
        let noteController = createNoteController()
        present(noteController, animated: true)
        noteController.setup(with: "", content: "") { [self] title, content in
            guard
                let entity = NSEntityDescription
                    .entity(forEntityName: "Note", in: managedObjectContext)
            else {
                print("Could not create entity description")
                return
            }

            guard
                let note = NSManagedObject(
                    entity: entity, insertInto: managedObjectContext
                ) as? Note
            else {
                print("Could not create note")
                return
            }
            note.title = title
            note.content = content
            note.creationDate = Date()
            do {
                try managedObjectContext.save()
                reloadNotes()
                dismiss(animated: true)
            } catch {
                print("Could not save context")
            }
        }
    }

    private func update(note: Note) {
        let noteController = createNoteController()
        present(noteController, animated: true)
        noteController.setup(
            with: note.title ?? "", content: note.content ?? ""
        ) { [self] title, content in
            note.title = title
            note.content = content
            do {
                try managedObjectContext.save()
                reloadNotes()
                dismiss(animated: true)
            } catch {
                print("Could not save context")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(
            UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier
        )
        reloadNotes()
    }

    private var notes: [Note] = []

    private lazy var managedObjectContext: NSManagedObjectContext = {
        guard
            let appDelegate = (UIApplication.shared.delegate as? AppDelegate)
        else {
            fatalError("Could not get app delegate")
        }

        return appDelegate.persistentContainer.viewContext
    }()

    private func reloadNotes() {
        do {
            notes = try managedObjectContext.fetch(Note.fetchRequest())
            tableView.reloadData()
        } catch {
            print("Could not load data")
        }
    }

    // MARK: - UITableViewDataSource

    func tableView(
        _ tableView: UITableView, numberOfRowsInSection section: Int
    ) -> Int {
        notes.count
    }

    private let reuseIdentifier: String = "Cell"
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = DateFormatter.dateFormat(
            fromTemplate: "dd.MM.yyyy, HH:mm", options: 0, locale: Locale.current
        )
        return formatter
    }()

    func tableView(
        _ tableView: UITableView, cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: reuseIdentifier, for: indexPath
        )
        let note = notes[indexPath.row]

        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = note.title ?? "Empty"
        let formattedDate = note.creationDate.map(dateFormatter.string)
        configuration.secondaryText = "\(formattedDate ?? "Unknown date") \(note.content ?? "")"
        cell.contentConfiguration = configuration
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let note = notes[indexPath.row]
        update(note: note)
    }

    func tableView(
        _ tableView: UITableView,
        trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath
    ) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(
            style: .destructive,
            title: "Delete"
        ) { [unowned self] _, _, completion in
            let note = notes[indexPath.row]
            managedObjectContext.delete(note)
            do {
                try managedObjectContext.save()
                notes.remove(at: indexPath.row)
                tableView.deleteRows(at: [ indexPath ], with: .automatic)
                completion(true)
            } catch {
                print("Could not delete note: \(error)")
                completion(true)
            }
        }
        return UISwipeActionsConfiguration(actions: [ action ])
    }
}

