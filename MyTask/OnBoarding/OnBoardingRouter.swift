//
//  OnBoardingRouter.swift
//  MyTask
//
//  Created by Danil on 03.08.2024.
//

import Foundation
import UIKit

// MARK: - TaskScreenRoute Protocol

protocol OnBoardingRoute {
    func openOnBoardingStartScreen() -> UIViewController
}

// MARK: - Default implementation of OnboardingRoute

extension OnBoardingRoute where Self: Router {
    func openOnBoardingStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = OnBoardingViewController()
        let model = OnBoardingModel()
        let presenter = OnBoardingPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        return viewController
    }
}

extension DefaultRouter: OnBoardingRoute {}
