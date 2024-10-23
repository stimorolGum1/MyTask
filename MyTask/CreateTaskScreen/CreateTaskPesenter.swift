//
//  CreateTaskPesenter.swift
//  MyTask
//
//  Created by Danil on 30.09.2024.
//

import Foundation

protocol CreateTaskPesenterProtocol: AnyObject {
    func closeCreateTask()
}

class CreateTaskPesenter {
    private weak var view: CreateTaskViewControllerProtocol?
    private let model: CreateTaskModel
    private let router: Routes
    typealias Routes = Closable
    
    init(view: CreateTaskViewControllerProtocol?, model: CreateTaskModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
    }
}

extension CreateTaskPesenter: CreateTaskPesenterProtocol {
    func closeCreateTask() {
        router.close()
    }
}
