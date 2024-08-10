//
//  NewAnimatedTransition.swift
//  M23
//
//  Created by Danil on 15.06.2023.
//

import Foundation

import UIKit

final class NewAnimatedTransition: NSObject {
    let animatedTransition: PicAnimatedTransition
    var isAnimated: Bool = true

    init(animatedTransition: PicAnimatedTransition, isAnimated: Bool = true) {
        self.animatedTransition = animatedTransition
        self.isAnimated = isAnimated
    }
}

extension NewAnimatedTransition: Transition {
    
    func open(_ viewController: UIViewController, from: UIViewController, completion: (() -> Void)?) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        from.present(viewController, animated: isAnimated, completion: completion)
    }

    func close(_ viewController: UIViewController, completion: (() -> Void)?) {
        viewController.dismiss(animated: isAnimated, completion: completion)
    }
}

extension NewAnimatedTransition: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = true
        return animatedTransition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatedTransition.isPresenting = false
        return animatedTransition
    }
}
