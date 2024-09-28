//
//  ToDoScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

protocol ToDoScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow()
}

final class ToDoScreenPresenter {
    
    private weak var view: ToDoScreenViewControllerProtocol?
    private let model: ToDoScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable
    
    init(view: ToDoScreenViewControllerProtocol?, model: ToDoScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
    }
}

extension OnProgressScreenPresenter: OnProgressScreenPresenterProtocol {
    func numberOfRowsInSection() -> Int {
        return 0
    }
    
    func dataAtRow() {
    }
}
