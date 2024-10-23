//
//  TaskViewScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 09.10.2024.
//

import Foundation

protocol TaskViewScreenPresenterProtocol: AnyObject {
    func closeTaskView()
}

class TaskViewScreenPresenter {
    private weak var view: TaskViewScreenViewControllerProtocol?
    private let model: TaskViewScreenModel
    private let router: Routes
    typealias Routes = Closable
    
    init(view: TaskViewScreenViewControllerProtocol?, model: TaskViewScreenModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
    }
}

extension TaskViewScreenPresenter: TaskViewScreenPresenterProtocol {
    func closeTaskView() {
        router.close()
    }
}
