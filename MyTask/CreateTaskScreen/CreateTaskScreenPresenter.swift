//
//  CreateTaskPresenter.swift
//  MyTask
//
//  Created by Danil on 30.09.2024.
//

import Foundation

// MARK: - Protocol Definition

protocol CreateTaskPesenterProtocol: AnyObject {
    func closeCreateTask()
    func createTask(taskDate: Date,
                    taskDescription: String,
                    taskName: String,
                    taskPriority: NSDecimalNumber,
                    taskStatus: NSDecimalNumber,
                    completion: @escaping (String) -> Void)
}

// MARK: - Presenter Implementation

final class CreateTaskPesenter {
    
    // MARK: - Dependencies
    
    private weak var view: CreateTaskViewControllerProtocol?
    private let model: CreateTaskModel
    private let router: Routes
    typealias Routes = Closable & TaskScreenRoute
    
    // MARK: - Initializer
    init(view: CreateTaskViewControllerProtocol?, model: CreateTaskModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
    }
}

// MARK: - CreateTaskPesenterProtocol
extension CreateTaskPesenter: CreateTaskPesenterProtocol {
    func closeCreateTask() {
        router.close()
    }
    
    func createTask(taskDate: Date,
                    taskDescription: String,
                    taskName: String,
                    taskPriority: NSDecimalNumber,
                    taskStatus: NSDecimalNumber,
                    completion: @escaping (String) -> Void) {
        StorageManager.shared.createTask(taskDate: taskDate,
                                         taskDescription: taskDescription,
                                         taskName: taskName,
                                         taskPriority: taskPriority,
                                         taskStatus: taskStatus) { status in
            completion(status)
        }
    }
}
