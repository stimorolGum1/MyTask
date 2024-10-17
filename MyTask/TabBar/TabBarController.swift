//
//  TabBarController.swift
//  MyTask
//
//  Created by Danil on 11.08.2024.
//

import UIKit
import Foundation

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setValue(CustomTabBar(), forKey: "tabBar")
    }
}
