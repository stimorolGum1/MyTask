//
//  SettingsRouter.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation
import UIKit

protocol SettingsRoute {
    func openSettings() -> UIViewController
}

extension SettingsRoute where Self: Router {
    func openSettings() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = SettingsViewController()
        let model = SettingsModel()
        let presenter = SettingsPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = "Settings"
        viewController.tabBarItem.image = UIImage(named: "settings")?.resizeImage()
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: SettingsRoute {}
