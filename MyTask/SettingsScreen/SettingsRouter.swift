//
//  SettingsRouter.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation
import UIKit

protocol SettingsRoute {
    func openSettings()
    func openSettingsStartScreen() -> UIViewController
}

extension SettingsRoute where Self: Router {
    private func openSettings(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = SettingsViewController()
        let model = SettingsModel()
        let presenter = SettingsPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openSettingsStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = SettingsViewController()
        let model = SettingsModel()
        let presenter = SettingsPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = "Settings"
        router.root = viewController
        return viewController
    }
    
    func openSettings() {
        openSettings(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: SettingsRoute {}
