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
}

extension AboutScreenRoute where Self: Router {
    private func openAboutScreen(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = AboutScreenViewController()
        let presenter = AboutScreenPresenter(view: viewController,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    func openAboutScreen() {
        openAboutScreen(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: AboutScreenRoute {}
