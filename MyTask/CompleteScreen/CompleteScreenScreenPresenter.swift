//
//  CompleteScreenScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation

protocol CompleteScreenPresenterProtocol: AnyObject {
    func numberOfRowsInSection() -> Int
    func dataAtRow()
}

final class CompleteScreenPresenter {
    
    private weak var view: CompleteScreenViewControllerProtocol?
    private let model: CompleteScreenModelProtocol
    private let router: Routes
    typealias Routes = Closable
    
    init(view: CompleteScreenViewControllerProtocol?, model: CompleteScreenModelProtocol, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
        
    }
}

extension CompleteScreenPresenter: CompleteScreenPresenterProtocol {
    func numberOfRowsInSection() -> Int {
        return 0
    }
    
    func dataAtRow() {
    }
}
