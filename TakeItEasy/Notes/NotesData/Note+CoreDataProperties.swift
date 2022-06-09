//
//  Note+CoreDataProperties.swift
//  TakeItEasy
//
//  Created by admin on 6/9/22.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var date: Date?
    @NSManaged public var text: String?

}

extension Note : Identifiable {

}
