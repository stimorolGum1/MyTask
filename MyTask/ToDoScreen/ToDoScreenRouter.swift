//
//  ToDoScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

protocol ToDoRoute {
    func openToDo()
    func openToDoStartScreen() -> UIViewController
}

extension ToDoRoute where Self: Router {
    private func openToDo(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = ToDoScreenViewController()
        let model = ToDoScreenModel()
        let presenter = ToDoScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openToDoStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = ToDoScreenViewController()
        let model = ToDoScreenModel()
        let presenter = ToDoScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = "ToDo"
        viewController.tabBarItem.image = UIImage(named: "todo")?.resizeImage()
        router.root = viewController
        return viewController
    }
    
    func openToDo() {
        openToDo(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: ToDoRoute {}
