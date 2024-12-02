//
//  AboutScreenPresenter.swift
//  MyTask
//
//  Created by Danil on 21.10.2024.
//

import Foundation

// MARK: - Presenter Protocol

protocol AboutScreenPresenterProtocol: AnyObject {
    func closeTaskView()
}

// MARK: - Presenter Implementation

final class AboutScreenPresenter {
    
    // MARK: - Properties
    
    weak var view: AboutScreenViewControllerProtocol?
    private let router: Routes
    typealias Routes = Closable
    
    // MARK: - Initializer
    
    init(view: AboutScreenViewControllerProtocol?, router: Routes) {
        self.view = view
        self.router = router
    }
}

// MARK: - SettingsPresenterProtocol

extension AboutScreenPresenter: AboutScreenPresenterProtocol {
    func closeTaskView() {
        router.close()
    }
}
