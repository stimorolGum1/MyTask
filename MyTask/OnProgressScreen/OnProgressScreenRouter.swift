//
//  OnProgressScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

// MARK: - ToDoRoute Protocol

protocol OnProgressRoute {
    func openOnProgress() -> UIViewController
}

// MARK: - Default implementation of ToDoRoute

extension OnProgressRoute where Self: Router {
    
    // MARK: - Open ToDo with Transition
    func openOnProgress() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = OnProgressScreenViewController()
        let model = OnProgressScreenModel()
        let presenter = OnProgressScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = Localization.onProgressHeader
        viewController.tabBarItem.image = UIImage(named: "onprogress")?.resizeImage()
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: OnProgressRoute {}
