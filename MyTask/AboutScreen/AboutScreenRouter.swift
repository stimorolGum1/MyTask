//
//  AboutScreenRouter.swift
//  MyTask
//
//  Created by Danil on 21.10.2024.
//

import Foundation
import UIKit

protocol AboutScreenRoute {
    func openAboutScreen()
    func openAboutScreenStartScreen() -> UIViewController
}

extension AboutScreenRoute where Self: Router {
    private func openAboutScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = AboutScreenViewController()
        let model = AboutScreenModel()
        let presenter = AboutScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openAboutScreenStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = AboutScreenViewController()
        let model = AboutScreenModel()
        let presenter = AboutScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        return viewController
    }
    
    func openAboutScreen() {
        openAboutScreen(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: AboutScreenRoute {}
