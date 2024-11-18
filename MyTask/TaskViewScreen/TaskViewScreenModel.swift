//
//  TaskViewScreenModel.swift
//  MyTask
//
//  Created by Danil on 09.10.2024.
//

import Foundation
import CoreData

// MARK: - TaskViewScreenModel

struct TaskViewScreenModel {
    let taskID: NSManagedObjectID
    let taskDate: Date?
    let taskDescription: String?
    let taskName: String?
    let taskPriority: NSDecimalNumber?
    let taskStatus: NSDecimalNumber?
}
