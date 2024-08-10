//
//  OnBoardingRouter.swift
//  MyTask
//
//  Created by Danil on 03.08.2024.
//

import Foundation
import UIKit

protocol OnBoardingRoute {
    func openOnBoarding()
    func openOnBoardingStartScreen() -> UIViewController
}

extension OnBoardingRoute where Self: Router {
    private func openOnBoarding(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = OnBoardingViewController()
        let model = OnBoardingModel()
        let presenter = OnBoardingPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
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
    
    func openOnBoarding() {
        openOnBoarding(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: OnBoardingRoute {}
