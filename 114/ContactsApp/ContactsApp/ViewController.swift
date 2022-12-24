//
//  ViewController.swift
//  ContactsApp
//
//  Created by Teacher on 24.12.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet private var tableView: UITableView!

    @IBAction private func addTap() {
        show(contact: nil)
    }

    private func show(contact: Contact?) {
        let contactController = ContactController.fromStoryboard()
        contactController.contact = contact
        contactController.close = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(contactController, animated: true)
    }

    private let cellIdentifier: String = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchedResults.delegate = self
        do {
            try fetchedResults.performFetch()
            tableView.reloadData()
        } catch {
            print("Could not fetch data: \(error)")
        }
    }

    func controllerDidChangeContent(
        _ controller: NSFetchedResultsController<NSFetchRequestResult>
    ) {
        tableView.reloadData()
    }

    private let fetchedResults: NSFetchedResultsController<Contact> = .init(
        fetchRequest: Contact.allContactsFetchRequest(),
        managedObjectContext: CoreDataStack.shared.viewContext,
        sectionNameKeyPath: nil,
        cacheName: nil
    )

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fetchedResults.fetchedObjects?.count ?? 0
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let contact = fetchedResults.object(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var contentConfiguration = UIListContentConfiguration.valueCell()
        contentConfiguration.image = UIImage(systemName: "person.circle")
        contentConfiguration.text = contact.name ?? "Unnamed"
        contentConfiguration.secondaryText = contact.phoneNumber
        cell.contentConfiguration = contentConfiguration
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let contact = fetchedResults.object(at: indexPath)
        show(contact: contact)
    }
}

