//
//  Tasks+CoreDataProperties.swift
//  
//
//  Created by Danil on 01.11.2024.
//
//

import Foundation
import CoreData

extension Tasks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tasks> {
        return NSFetchRequest<Tasks>(entityName: "Tasks")
    }

    @NSManaged public var taskDate: Date?
    @NSManaged public var taskDescription: String?
    @NSManaged public var taskName: String?
    @NSManaged public var taskPriority: NSDecimalNumber?
    @NSManaged public var taskStatus: NSDecimalNumber?

}
