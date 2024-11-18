//
//  OnProgressScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

// MARK: - Presenter Protocol

protocol OnProgressScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow(index: IndexPath) -> Tasks
    func openTaskView(data: TaskViewScreenModel)
    func makeSearch(searchText: String)
}

// MARK: - Presenter Implementation

final class OnProgressScreenPresenter {
    
    // MARK: - Properties
    
    private weak var view: OnProgressScreenViewControllerProtocol?
    private let model: OnProgressScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable & TaskViewRoute
    
    // MARK: - Initializer
    
    init(view: OnProgressScreenViewControllerProtocol, model: OnProgressScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
        model.onTasksUpdated = { [weak self] in
            self?.view?.updateOnProgressTableView()
        }

        model.onEmptyViewToggle = { [weak self] in
            self?.view?.toggleEmptyView()
        }
    }
}

// MARK: - OnProgressScreenPresenterProtocol

extension OnProgressScreenPresenter: OnProgressScreenPresenterProtocol {
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
