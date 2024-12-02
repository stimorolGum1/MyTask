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
        setupTabBarSpacing()
    }
    
    private func setupTabBarSpacing() { // TODO: пока так оставить 
            guard let items = tabBar.items else { return }
            items[0].titlePositionAdjustment = UIOffset(horizontal: -5, vertical: 0) // Сдвигаем левую вкладку
            items[1].titlePositionAdjustment = UIOffset(horizontal: -25, vertical: 0)  // Сдвигаем к центру
            items[2].titlePositionAdjustment = UIOffset(horizontal: 25, vertical: 0)   // Сдвигаем к центру от кнопки
            items[3].titlePositionAdjustment = UIOffset(horizontal: 5, vertical: 0)  // Сдвигаем правую вкладку
        }
}

// MARK: - CustomTabBarControllerProtocol Conformance

extension CustomTabBarController: CustomTabBarControllerProtocol {
    func openCreateTask() {
        presenter.openCreateTask()
    }
}
