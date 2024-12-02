//
//  StorageManager.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation
import CoreData

// MARK: - StorageManager

final class StorageManager { 
    
    static let shared = StorageManager()
    private init() {}
    
    // MARK: - Core Data Stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Tasks")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    // MARK: - Multicast Delegate
    
    private let multicastDelegate = WipeStorageMulticastDelegateClass<WipeStorageDelegate>()
        
    func addDelegate(_ delegate: WipeStorageDelegate) {
            multicastDelegate.addDelegate(delegate)
        }
        
    func removeDelegate(_ delegate: WipeStorageDelegate) {
            multicastDelegate.removeDelegate(delegate)
        }
    
    // MARK: - CRUD Operations
    
    // MARK: Create Task
    
    func createTask(
        taskDate: Date,
        taskDescription: String,
        taskName: String,
        taskPriority: NSDecimalNumber,
        taskStatus: NSDecimalNumber,
        completion: @escaping (String) -> Void
    ) {
        let file = Tasks(context: context)
        file.taskDate = taskDate
        file.taskDescription = taskDescription
        file.taskName = taskName
        file.taskPriority = taskPriority
        file.taskStatus = taskStatus
        if context.hasChanges {
            do {
                try context.save()
                completion(Localization.taskCreate)
            } catch {
                context.rollback()
            }
        }
    }
    
    // MARK: Update Task
    
    func updateTask(
        taskID: NSManagedObjectID,
        taskDate: Date? = nil,
        taskDescription: String? = nil,
        taskName: String? = nil,
        taskPriority: NSDecimalNumber? = nil,
        taskStatus: NSDecimalNumber? = nil,
        completion: @escaping (String) -> Void
    ) {
        do {
            let task = try context.existingObject(with: taskID) as? Tasks
            guard let task = task else {
                completion(Localization.taskNotFound)
                return
            }
            
            var changesDetected = false
            
            if let newDate = taskDate, task.taskDate != newDate {
                task.taskDate = newDate
                changesDetected = true
            }
            
            if let newDescription = taskDescription, task.taskDescription != newDescription {
                task.taskDescription = newDescription
                changesDetected = true
            }
            
            if let newName = taskName, task.taskName != newName {
                task.taskName = newName
                changesDetected = true
            }
            
            if let newPriority = taskPriority, task.taskPriority != newPriority {
                task.taskPriority = newPriority
                changesDetected = true
            }
            
            if let newStatus = taskStatus, task.taskStatus != newStatus {
                task.taskStatus = newStatus
                changesDetected = true
            }
            
            if changesDetected {
                try context.save()
                completion(Localization.taskUpdate)
            } else {
                completion(Localization.taskNotChange)
            }
        } catch {
            context.rollback()
        }
    }
    
    // MARK: Delete Task
    
    func deleteTask(id: NSManagedObjectID, completion: @escaping (String) -> Void) {
        do {
            let object = try context.existingObject(with: id)
            context.delete(object)
            if context.hasChanges {
                try context.save()
                completion(Localization.deleteTask)
            }
        } catch {
            context.rollback()
        }
    }
    
    // MARK: Wipe Storage
    
    func wipeStorage() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Tasks.fetchRequest() as! NSFetchRequest<NSFetchRequestResult>
        do {
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
            try context.execute(deleteRequest)
            multicastDelegate.invoke { $0.storageWiped() }
        } catch {
            context.rollback()
        }
    }
    
    // MARK: - Fetching Data
    
    func createItemsController(
            taskStatus: Int,
            searchText: String,
            delegate: NSFetchedResultsControllerDelegate?
        ) -> NSFetchedResultsController<Tasks> {
            let fetchRequest: NSFetchRequest<Tasks> = Tasks.fetchRequest()
            var predicates = [NSPredicate(format: "taskStatus == %d", taskStatus)]
            if !searchText.isEmpty {
                predicates.append(NSPredicate(format: "taskName CONTAINS[cd] %@", searchText))
            }
            fetchRequest.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
            fetchRequest.sortDescriptors = [NSSortDescriptor(key: "taskDate", ascending: true)]
            fetchRequest.fetchBatchSize = 10
            let fetchedResultsController = NSFetchedResultsController(
                fetchRequest: fetchRequest,
                managedObjectContext: context,
                sectionNameKeyPath: nil,
                cacheName: nil
            )
            fetchedResultsController.delegate = delegate
            return fetchedResultsController
        }

    // MARK: Count of Items
    
    func countOfItems(taskStatus: Int) -> Int {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = Tasks.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "taskStatus == %d", taskStatus)
        do {
            return try context.count(for: fetchRequest)
        } catch {
            context.rollback()
            return 0
        }
    }
}
