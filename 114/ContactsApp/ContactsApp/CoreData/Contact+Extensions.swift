//
//  Contact+Extensions.swift
//  ContactsApp
//
//  Created by Teacher on 24.12.2022.
//

import Foundation
import CoreData

extension Contact {
    class func allContactsFetchRequest(
    ) -> NSFetchRequest<Contact> {
        let fetchRequest = NSFetchRequest<Contact>(entityName: "Contact")
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \Contact.name, ascending: true
            )
        ]
        return fetchRequest
    }
}
