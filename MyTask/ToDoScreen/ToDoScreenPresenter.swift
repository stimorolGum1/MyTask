//
//  ToDoScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

// MARK: - Presenter Protocol

protocol ToDoScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow(index: IndexPath) -> Tasks
    func openTaskView(data: TaskViewScreenModel)
    func makeSearch(searchText: String)
}

// MARK: - Presenter Implementation

final class ToDoScreenPresenter {

    // MARK: - Properties

    private weak var view: ToDoScreenViewControllerProtocol?
    private let model: ToDoScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable & TaskViewRoute

    // MARK: - Initializer

    init(view: ToDoScreenViewControllerProtocol, model: ToDoScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
        model.onTasksUpdated = { [weak self] in
            self?.view?.updateToDoTableView()
        }

        model.onEmptyViewToggle = { [weak self] in
            self?.view?.toggleEmptyView()
        }
    }
}

// MARK: - ToDoScreenPresenterProtocol

extension ToDoScreenPresenter: ToDoScreenPresenterProtocol {
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
        model.setupFetchedResultsController(searchText: searchText)
    }
}
