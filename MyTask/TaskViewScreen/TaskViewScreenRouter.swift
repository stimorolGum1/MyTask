//
//  TaskViewScreenRouter.swift
//  MyTask
//
//  Created by Danil on 09.10.2024.
//

import Foundation
import UIKit

protocol TaskViewRoute {
    func openTaskView(data: TaskViewScreenModel)
}

extension TaskViewRoute where Self: Router {
    private func openTaskView(with transition: Transition, data: TaskViewScreenModel) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = TaskViewScreenViewController()
        let model = TaskViewScreenModel(taskID: data.taskID,
                                        taskDate: data.taskDate,
                                        taskDescription: data.taskDescription,
                                        taskName: data.taskName,
                                        taskPriority: data.taskPriority,
                                        taskStatus: data.taskStatus)
        let presenter = TaskViewScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openTaskView(data: TaskViewScreenModel) {
        openTaskView(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()), data: data)
    }
}

extension DefaultRouter: TaskViewRoute {}
