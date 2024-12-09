//
//  TaskScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

// MARK: - Presenter Protocol

protocol TaskScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow(index: IndexPath) -> Tasks
    func openTaskView(data: TaskViewScreenModel)
    func makeSearch(searchText: String)
    func fetchData()
}

// MARK: - Presenter Implementation

final class TaskScreenPresenter {
    
    // MARK: - Properties
    
    private weak var view: TaskScreenViewControllerProtocol?
    private let model: TaskScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable & TaskViewRoute
    private var timer: Timer?
    
    // MARK: - Initializer
    
    init(view: TaskScreenViewControllerProtocol, model: TaskScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
        model.onTasksUpdated = { [weak self] in
            self?.view?.updateTaskTableView()
        }
        
        model.onEmptyViewToggle = { [weak self] in
            self?.view?.toggleEmptyView()
        }
    }
}

// MARK: - ToDoScreenPresenterProtocol

extension TaskScreenPresenter: TaskScreenPresenterProtocol {
    func numberOfRowsInSection() -> Int {
        return model.fetchedResultsController.sections?.first?.numberOfObjects ?? 0
    }
    
    func dataAtRow(index: IndexPath) -> Tasks {
        return model.fetchedResultsController.object(at: index)
    }
    
    func openTaskView(data: TaskViewScreenModel) {
        router.openTaskView(data: data)
    }
    
    func makeSearch(searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [weak self] _ in
            searchText.isEmpty ? () : self?.model.fetchData(searchText: searchText)
        }
    }
    
    func fetchData() {
        model.fetchData(searchText: "")
    }
}
