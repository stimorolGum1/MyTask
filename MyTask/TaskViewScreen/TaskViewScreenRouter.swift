//
//  TaskViewScreenRouter.swift
//  MyTask
//
//  Created by Danil on 09.10.2024.
//

import Foundation
import UIKit

protocol TaskViewRoute {
    func openTaskView()
    func openTaskViewStartScreen() -> UIViewController
}

extension TaskViewRoute where Self: Router {
    private func openTaskView(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = TaskViewScreenViewController()
        let model = TaskViewScreenModel()
        let presenter = TaskViewScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openTaskViewStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = TaskViewScreenViewController()
        let model = TaskViewScreenModel()
        let presenter = TaskViewScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        return viewController
    }
    
    func openTaskView() {
        openTaskView(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: TaskViewRoute {}
