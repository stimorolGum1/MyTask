//
//  TabBarController.swift
//  MyTask
//
//  Created by Danil on 11.08.2024.
//

import UIKit
import Foundation

protocol CustomTabBarControllerProtocol: AnyObject {
    func openCreateTask()
}

final class CustomTabBarController: UITabBarController {
    
    var presenter: CustomTabBarPresenterProtocol!
    var customTabBar: CustomTabBarDelegate!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setValue(customTabBar, forKey: "tabBar")
        viewControllers = presenter.prepareTabs()
    }
}

extension CustomTabBarController: CustomTabBarControllerProtocol {
    func openCreateTask() {
        presenter.openCreateTask()
    }
}
