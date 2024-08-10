//
//  PicAnimatedTransition.swift
//  M23
//
//  Created by Danil on 15.06.2023.
//

import UIKit

final class PicAnimatedTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var isPresenting: Bool = true
    let img = UIImage(named: "cat")
    var imageView: UIImageView? = nil
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            present(using: transitionContext)
        } else {
            dismiss(using: transitionContext)
        }
    }
    private func present(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        imageView = UIImageView(image: img)
        containerView.addSubview(toView)
        guard let imageView = imageView else { return }
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: containerView.heightAnchor).isActive = true
        imageView.alpha = 0.0
        toView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            imageView.alpha = 1.0
        }, completion: { _ in
            imageView.alpha = 0.0
            toView.alpha = 1.0
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    private func dismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let imageView = imageView else { return }
        fromView.alpha = 1.0
        imageView.alpha = 0.0
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.alpha = 0.0
            imageView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
