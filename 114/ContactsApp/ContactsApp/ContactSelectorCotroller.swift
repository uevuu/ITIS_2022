//
//  ContactSelectorCotroller.swift
//  ContactsApp
//
//  Created by Teacher on 24.12.2022.
//

import UIKit
import CoreData

class ContactSelectorController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    enum Kind {
        case bff
        case parents
        case children
        case friends
    }

    var kind: Kind = .friends
    var sourceContact: Contact!
    var close: (() -> Void)?

    @IBOutlet private var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            systemItem: .save,
            primaryAction: UIAction { [unowned self] action in
                save()
            }
        )
        loadData()
    }

    private func loadData() {
        let fetchRequest: NSFetchRequest<Contact> = Contact.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "SELF != %@", sourceContact)
        do {
            allContacts = try CoreDataStack.shared.viewContext.fetch(fetchRequest)
            getSelectedContacts()
            tableView.reloadData()
        } catch {
            print("Could not load contacts: \(error)")
        }
    }

    private func getSelectedContacts() {
        switch kind {
            case .friends:
                selectedContacts = Set(sourceContact.friends?.allObjects as? [Contact] ?? [])
            case .bff:
                if let bff = sourceContact.bff {
                    selectedContacts = [ bff ]
                } else {
                    selectedContacts = []
                }
            case .parents, .children:
                break
        }
    }

    private var allContacts: [Contact] = []
    private var selectedContacts: Set<Contact> = []

    private func save() {
        switch kind {
            case .friends:
                saveFriends()
            case .bff:
                saveBff()
            case .parents, .children:
                break
        }
        CoreDataStack.shared.save()
        close?()
    }

    private func saveFriends() {
        sourceContact.friends = NSSet(set: selectedContacts)
    }

    private func saveBff() {
        sourceContact.bff = selectedContacts.first
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        allContacts.count
    }

    private let cellIdentifier: String = "Cell"

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contact = allContacts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        var configuration = UIListContentConfiguration.cell()
        configuration.text = contact.name
        cell.contentConfiguration = configuration
        cell.accessoryType = selectedContacts.contains(contact) ? .checkmark : .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch kind {
            case .friends:
                selectFriend(at: indexPath)
            case .bff:
                selectBff(at: indexPath)
            case .children, .parents:
                break
        }
    }

    private func reload() {
        tableView.reloadData()
    }

    private func selectFriend(at indexPath: IndexPath) {
        let contact = allContacts[indexPath.row]

        if selectedContacts.contains(contact) {
            selectedContacts.remove(contact)
        } else {
            selectedContacts.insert(contact)
        }
        reload()
    }

    private func selectBff(at indexPath: IndexPath) {
        let contact = allContacts[indexPath.row]

        if selectedContacts.first == contact {
            selectedContacts = []
        } else {
            selectedContacts = [ contact ]
        }
        reload()
    }
}
