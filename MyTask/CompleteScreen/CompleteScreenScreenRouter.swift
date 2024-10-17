//
//  CompleteScreenScreenRouter.swift
//  MyTask
//
//  Created by Danil on 12.08.2024.
//

import Foundation
import UIKit

protocol CompleteRoute {
    func openComplete()
    func openCompleteStartScreen() -> UIViewController
}

extension CompleteRoute where Self: Router {
    private func openComplete(with transition: Transition) {
        let router = DefaultRouter(rootTransition: transition)
        let viewController = CompleteScreenViewController()
        let model = CompleteScreenModel()
        let presenter = CompleteScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        router.root = viewController
        route(to: viewController, as: transition)
    }
    
    func openCompleteStartScreen() -> UIViewController {
        let router = DefaultRouter(rootTransition: EmptyTransition())
        let viewController = CompleteScreenViewController()
        let model = CompleteScreenModel()
        let presenter = CompleteScreenPresenter(view: viewController,
                                            model: model,
                                            router: router)
        viewController.presenter = presenter
        viewController.title = "Complete"
        viewController.tabBarItem.image = UIImage(named: "complete")?.resizeImage()
        router.root = viewController
        return viewController
    }
    
    func openComplete() {
        openComplete(with: AnimatedTransition(animatedTransition: FadeAnimatedTransitioning()))
    }
}

extension DefaultRouter: CompleteRoute {}
