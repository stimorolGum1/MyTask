//
//  TabBarController.swift
//  MyTask
//
//  Created by Danil on 11.08.2024.
//

import UIKit
import Foundation

// MARK: - CustomTabBarControllerProtocol

protocol CustomTabBarControllerProtocol: AnyObject {
    func openCreateTask()
}

// MARK: - CustomTabBarController

final class CustomTabBarController: UITabBarController {
    
    var presenter: CustomTabBarPresenterProtocol!
    var customTabBar: CustomTabBarDelegate!
    
    // MARK: - Lifecycle Methods
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValue(customTabBar, forKey: "tabBar")
        viewControllers = presenter.prepareTabs()
    }
}

// MARK: - CustomTabBarControllerProtocol Conformance

extension CustomTabBarController: CustomTabBarControllerProtocol {
    func openCreateTask() {
        presenter.openCreateTask()
    }
}
