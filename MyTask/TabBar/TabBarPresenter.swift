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

final class CustomTabBarPresenter {
    
    // MARK: - Properties
    
    weak var view: CustomTabBarControllerProtocol?
    var model: CustomTabBarModel
    private let router: Routes
    typealias Routes = Closable & TaskScreenRoute & SettingsRoute & CreateTaskRoute
    
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
        model.items = [router.openTaskScreen(nameOfIcon: "todo", named: Localization.toDoHeader, taskStatus: 1),
                       router.openTaskScreen(nameOfIcon: "onprogress", named: Localization.onProgress, taskStatus: 2),
                       router.openTaskScreen(nameOfIcon: "complete", named: Localization.complete, taskStatus: 3),
                       router.openSettings()]
        return model.items
    }
}
