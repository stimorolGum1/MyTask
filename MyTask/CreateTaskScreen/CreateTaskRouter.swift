//
//  CreateTaskRouter.swift
//  MyTask
//
//  Created by Danil on 30.09.2024.
//

import Foundation
import UIKit

protocol CreateTaskRoute {
    func openCreateTask()
    func openCreateTaskStartScreen() -> UIViewController
}

extension CreateTaskRoute where Self: Router {
    private func openCreateTask(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = CreateTaskViewController()
        let model = CreateTaskModel()
        let presenter = CreateTaskPesenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openCreateTaskStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = CreateTaskViewController()
        let model = CreateTaskModel()
        let presenter = CreateTaskPesenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        return viewController
    }
    
    func openCreateTask() {
        openCreateTask(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: CreateTaskRoute {}
