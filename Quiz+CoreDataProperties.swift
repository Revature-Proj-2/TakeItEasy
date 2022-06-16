//
//  Quiz+CoreDataProperties.swift
//  TakeItEasy
//
//  Created by xcode on 6/13/22.
//
//

import Foundation
import CoreData


extension Quizlet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quizlet> {
        return NSFetchRequest<Quizlet>(entityName: "Quizlet")
    }

    @NSManaged public var prizePoints: Int32
    @NSManaged public var lastQuiz: Int32
    @NSManaged public var totalQuiz: NSDecimalNumber?
    @NSManaged public var relationship: User?

}

extension Quizlet : Identifiable {

}
