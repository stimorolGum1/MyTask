//
//  OnProgressScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

protocol OnProgressScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow()
}

final class OnProgressScreenPresenter {
    
    private weak var view: OnProgressScreenViewControllerProtocol?
    private let model: OnProgressScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable
    
    init(view: OnProgressScreenViewControllerProtocol?, model: OnProgressScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
    }
}

extension ToDoScreenPresenter: ToDoScreenPresenterProtocol {
    func numberOfRowsInSection() -> Int {
        return 0
    }
    
    func dataAtRow() {
    }
}
