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

// добавить для удаления/обновления
/*
 
 func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     tableView.beginUpdates()
 }
  
 func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
     switch type {
     case .insert:
         tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
     case .delete:
         tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
     case .move:
         break
     case .update:
         break
     }
 }
  
 func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
     switch type {
     case .insert:
         tableView.insertRows(at: [newIndexPath!], with: .fade)
     case .delete:
         tableView.deleteRows(at: [indexPath!], with: .fade)
     case .update:
         tableView.reloadRows(at: [indexPath!], with: .fade)
     case .move:
         tableView.moveRow(at: indexPath!, to: newIndexPath!)
     }
 }
  
 func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
     tableView.endUpdates()
 }
 */
