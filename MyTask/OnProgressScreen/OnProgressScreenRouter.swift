//
//  OnProgressScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

protocol OnProgressRoute {
    func openOnProgress()
    func openOnProgressStartScreen() -> UIViewController
}

extension OnProgressRoute where Self: Router {
    private func openOnProgress(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = OnProgressScreenViewController()
        let model = OnProgressScreenModel()
        let presenter = OnProgressScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openOnProgressStartScreen() -> UIViewController {
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
    
    func openOnProgress() {
        openOnProgress(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: OnProgressRoute {}
