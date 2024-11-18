//
//  ToDoScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

// MARK: - ToDoRoute Protocol

protocol ToDoRoute {
    func openToDo() -> UIViewController
}

// MARK: - Default implementation of ToDoRoute

extension ToDoRoute where Self: Router {

    // MARK: - Open ToDo with Transition
    func openToDo() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = ToDoScreenViewController()
        let model = ToDoScreenModel()
        let presenter = ToDoScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = Localization.toDoHeader
        viewController.tabBarItem.image = UIImage(named: "todo")?.resizeImage()
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: ToDoRoute {}
