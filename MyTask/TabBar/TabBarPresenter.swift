//
//  TabBarPresenter.swift
//  MyTask
//
//  Created by Danil on 19.10.2024.
//

import Foundation
import UIKit

// MARK: - Presenter Protocol

protocol CustomTabBarPresenterProtocol: AnyObject {
    func prepareTabs() -> [UIViewController]
    func openCreateTask()
}

// MARK: - Presenter Implementation

class CustomTabBarPresenter {
    
    // MARK: - Properties
    
    weak var view: CustomTabBarControllerProtocol?
    var model: CustomTabBarModel
    private let router: Routes
    typealias Routes = Closable & ToDoRoute & OnProgressRoute & CompleteRoute & SettingsRoute & CreateTaskRoute
    
    // MARK: - Initializer
    
    init(view: CustomTabBarControllerProtocol, model: CustomTabBarModel, router: Routes ) {
        self.view = view
        self.model = model
        self.router = router
    }
}

// MARK: - CustomTabBarPresenterProtocol

extension CustomTabBarPresenter: CustomTabBarPresenterProtocol {
    func openCreateTask() {
        router.openCreateTask()
    }
    
    func prepareTabs() -> [UIViewController] {
        model.items = [router.openToDo(), router.openOnProgress(), router.openComplete(), router.openSettings()]
        return model.items
    }
}
