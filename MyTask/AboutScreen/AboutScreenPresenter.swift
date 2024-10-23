//
//  AboutScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 21.10.2024.
//

import Foundation

protocol AboutScreenPresenterProtocol: AnyObject {
    func closeTaskView()
}

class AboutScreenPresenter {
    weak var view: AboutScreenViewControllerProtocol?
    private let model: AboutScreenModel
    private let router: Routes
    typealias Routes = Closable
    
    init(view: AboutScreenViewControllerProtocol?, model: AboutScreenModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
    }
}

extension AboutScreenPresenter: AboutScreenPresenterProtocol {
    func closeTaskView() {
        router.close()
    }
}
