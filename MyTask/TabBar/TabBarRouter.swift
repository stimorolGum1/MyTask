//
//  TabBarRouter.swift
//  MyTask
//
//  Created by Danil on 17.10.2024.
//

import Foundation
import UIKit

protocol TabBarRoute {
    func openTabBar()
    func openTabBarStartScreen() -> UIViewController
}

extension TabBarRoute where Self: Router {
    func openTabBar(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = CustomTabBarController()
        let tabBar = CustomTabBar()
        let model = CustomTabBarModel()
        let presenter = CustomTabBarPresenter(view: viewController,
                                              model: model,
                                              router: router)
        viewController.presenter = presenter
        viewController.customTabBar = tabBar
        tabBar.customDelegate = viewController
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openTabBarStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = CustomTabBarController()
        let tabBar = CustomTabBar()
        let model = CustomTabBarModel()
        let presenter = CustomTabBarPresenter(view: viewController,
                                              model: model,
                                              router: router)
        viewController.presenter = presenter
        viewController.customTabBar = tabBar
        tabBar.customDelegate = viewController
        router.root = viewController
        return viewController
    }

    func openTabBar() {
        openTabBar(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: TabBarRoute {}
