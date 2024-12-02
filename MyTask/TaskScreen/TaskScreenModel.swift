//
//  ToDoScreenModel.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import CoreData

// MARK: - TaskScreenModelProtocol

protocol TaskScreenModelProtocol: AnyObject {
    var fetchedResultsController: NSFetchedResultsController<Tasks>! { get }
    var onTasksUpdated: (() -> Void)? { get set }
    var onEmptyViewToggle: (() -> Void)? { get set }
    func fetchData(searchText: String)
}

// MARK: - TaskScreenModel

final class TaskScreenModel: NSObject {
    
    // MARK: - Properties
    
    var fetchedResultsController: NSFetchedResultsController<Tasks>!
    var onTasksUpdated: (() -> Void)?
    var onEmptyViewToggle: (() -> Void)?
    var taskStatus: Int?
    
    // MARK: - Initialization
    
    init(taskStatus: Int) {
        self.taskStatus = taskStatus
        super.init()
        fetchData()
        StorageManager.shared.addDelegate(self)
    }
    
    deinit {
        StorageManager.shared.removeDelegate(self)
    }
    
    // MARK: - Methods
    
    private func checkIfEmpty() {
        let isEmpty = fetchedResultsController.fetchedObjects?.isEmpty ?? true
        isEmpty ? onEmptyViewToggle?() : ()
    }
}

// MARK: - TaskScreenModelProtocol

extension TaskScreenModel: TaskScreenModelProtocol {
    func fetchData(searchText: String = "") {
        fetchedResultsController = StorageManager.shared.createItemsController(
            taskStatus: taskStatus!,
            searchText: searchText,
            delegate: self
        )
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension TaskScreenModel: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onTasksUpdated?()
        checkIfEmpty()
    }
}

// MARK: - WipeStorageDelegate

extension TaskScreenModel: WipeStorageDelegate {
    func storageWiped() {
        fetchData()
    }
}
