//
//  TabBarPresenter.swift
//  MyTask
//
//  Created by Danil on 19.10.2024.
//

import Foundation
import UIKit

protocol CustomTabBarPresenterProtocol: AnyObject {
    func prepareTabs() -> [UIViewController]
    func openCreateTask()
}

class CustomTabBarPresenter {
    
    weak var view: CustomTabBarControllerProtocol?
    var model: CustomTabBarModel
    private let router: Routes
    typealias Routes = Closable & ToDoRoute & OnProgressRoute & CompleteRoute & SettingsRoute & CreateTaskRoute
    
    init(view: CustomTabBarControllerProtocol, model: CustomTabBarModel, router: Routes ) {
        self.view = view
        self.model = model
        self.router = router
    }
}

extension CustomTabBarPresenter: CustomTabBarPresenterProtocol {
    func openCreateTask() {
        router.openCreateTask()
    }
    
    func prepareTabs() -> [UIViewController] {
        model.items = [router.openToDoStartScreen(), router.openOnProgressStartScreen(), router.openCompleteStartScreen(), router.openSettingsStartScreen()]
        return model.items
    }
}
