//
//  ToDoScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

// MARK: - ToDoRoute Protocol

protocol TaskScreenRoute {
    func openTaskScreen(nameOfIcon: String, named: String, taskStatus: Int) -> UIViewController
}

// MARK: - Default implementation of TaskScreenRoute

extension TaskScreenRoute where Self: Router {

    // MARK: - Open ToDo with Transition
    func openTaskScreen(nameOfIcon: String, named: String, taskStatus: Int) -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = TaskScreenViewController()
        let model = TaskScreenModel(taskStatus: taskStatus)
        let presenter = TaskScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = named
        viewController.tabBarItem.image = UIImage(named: nameOfIcon)?.resizeImage()
        viewController.headerLabel.text = named
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: TaskScreenRoute {}
