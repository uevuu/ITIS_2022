//
//  Note+CoreDataProperties.swift
//  NotesWithCoreData
//
//  Created by Teacher on 10.12.2022.
//
//

import Foundation
import CoreData

extension Note {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        let request = NSFetchRequest<Note>(entityName: "Note")
        request.sortDescriptors = [
            NSSortDescriptor(
                keyPath: \Note.creationDate, ascending: false
            )
        ]
        return request
    }

    @NSManaged public var title: String?
    @NSManaged public var content: String?
    @NSManaged public var creationDate: Date?
}

extension Note : Identifiable {}
