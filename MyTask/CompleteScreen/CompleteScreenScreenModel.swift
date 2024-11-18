//
//  CompleteScreenScreenModel.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import CoreData

// MARK: - ToDoScreenModelProtocol

protocol CompleteScreenModelProtocol: AnyObject {
    var fetchedResultsController: NSFetchedResultsController<Tasks>! { get }
    var onTasksUpdated: (() -> Void)? { get set }
    var onEmptyViewToggle: (() -> Void)? { get set }
    func setupFetchedResultsController(searchText: String)
}

// MARK: - ToDoScreenModel

final class CompleteScreenModel: NSObject {
    
    // MARK: - Properties
    
    var fetchedResultsController: NSFetchedResultsController<Tasks>!
    var onTasksUpdated: (() -> Void)?
    var onEmptyViewToggle: (() -> Void)?
    
    // MARK: - Initialization

    override init() {
        super.init()
        setupFetchedResultsController()
        StorageManager.shared.addDelegate(self)
    }
    
    deinit {
        StorageManager.shared.removeDelegate(self)
    }

    // MARK: - Methods

    private func checkIfEmpty() {
        let isEmpty = fetchedResultsController.fetchedObjects?.isEmpty ?? true
        if isEmpty {
            onEmptyViewToggle?()
        }
    }
}

// MARK: - CompleteScreenModelProtocol

extension CompleteScreenModel: CompleteScreenModelProtocol {
    func setupFetchedResultsController(searchText: String = "") {
        fetchedResultsController = StorageManager.shared.createItemsController(
            taskStatus: 3,
            searchText: searchText,
            delegate: self
        )
        do {
            try fetchedResultsController.performFetch()
            onTasksUpdated?()
            checkIfEmpty()
        } catch {
            print("Error performing fetch: \(error.localizedDescription)")
        }
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension CompleteScreenModel: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        onTasksUpdated?()
        checkIfEmpty()
    }
}

// MARK: - WipeStorageDelegate

extension CompleteScreenModel: WipeStorageDelegate {
    func storageWiped() {
        setupFetchedResultsController()
    }
}
