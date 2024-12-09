//
//  TaskViewScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 09.10.2024.
//

import Foundation
import CoreData

// MARK: - Presenter Protocol

protocol TaskViewScreenPresenterProtocol: AnyObject {
    func closeTaskView()
    func getData() -> TaskViewScreenModel
    func deleteTask(completion: @escaping (String) -> Void)
    func updateTask(taskDate: Date?,
                    taskDescription: String?,
                    taskName: String?,
                    taskPriority: NSDecimalNumber?,
                    taskStatus: NSDecimalNumber?,
                    completion: @escaping (String) -> Void)
}

// MARK: - Presenter Implementation

final class TaskViewScreenPresenter {
    
    // MARK: - Properties
    
    private weak var view: TaskViewScreenViewControllerProtocol?
    private let model: TaskViewScreenModel
    private let router: Routes
    typealias Routes = Closable
    private let pushManager: PushManager
    
    // MARK: - Initializer
    
    init(view: TaskViewScreenViewControllerProtocol?, model: TaskViewScreenModel, router: Routes, pushManager: PushManager) {
        self.view = view
        self.model = model
        self.router = router
        self.pushManager = pushManager
    }
}

// MARK: - TaskViewScreenPresenterProtocol

extension TaskViewScreenPresenter: TaskViewScreenPresenterProtocol {
    func closeTaskView() {
        router.close()
    }
    
    func getData() -> TaskViewScreenModel {
        return model
    }
    
    func deleteTask(completion: @escaping (String) -> Void) {
        StorageManager.shared.deleteTask(id: model.taskID) { [weak self] status in
            completion(status)
            self?.pushManager.removeFromNotification(id: self?.model.taskID ?? NSManagedObjectID())
        }
    }
    
    func updateTask(taskDate: Date?,
                    taskDescription: String?,
                    taskName: String?,
                    taskPriority: NSDecimalNumber?,
                    taskStatus: NSDecimalNumber?,
                    completion: @escaping (String) -> Void) {
        StorageManager.shared.updateTask(taskID: model.taskID,
                                         taskDate: taskDate,
                                         taskDescription: taskDescription,
                                         taskName: taskName,
                                         taskPriority: taskPriority,
                                         taskStatus: taskStatus,
                                         completion: { status in
            completion(status)
        },
                                         completionForPush: { [weak self] taskName, taskDate in
            self?.pushManager.updatePushNotification(task: taskName, dueDate: taskDate.addingTimeInterval(-60 * 60), id: self?.model.taskID ?? NSManagedObjectID())
        })
    }
}
