//
//  CompleteScreenScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

// MARK: - ToDoRoute Protocol

protocol CompleteRoute {
    func openComplete() -> UIViewController
}

// MARK: - Default implementation of ToDoRoute

extension CompleteRoute where Self: Router {
    
    // MARK: - Open ToDo with Transition
    func openComplete() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = CompleteScreenViewController()
        let model = CompleteScreenModel()
        let presenter = CompleteScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = Localization.completeHeader
        viewController.tabBarItem.image = UIImage(named: "complete")?.resizeImage()
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: CompleteRoute {}
