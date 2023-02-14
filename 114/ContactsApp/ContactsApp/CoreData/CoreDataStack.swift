//
//  CoreDataStack.swift
//  ContactsApp
//
//  Created by Teacher on 24.12.2022.
//

import CoreData

class CoreDataStack {
    static var shared: CoreDataStack = .init(name: "ContactsApp")

    lazy var viewContext: NSManagedObjectContext = container.viewContext

    private let container: NSPersistentContainer

    init(name: String) {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("Could not load persistent stores: \(error)")
            }
        }
        self.container = container
    }

    func save() {
        guard viewContext.hasChanges else { return }

        do {
            try viewContext.save()
        } catch {
            print("Could not save changes: \(error)")
        }
    }
}
