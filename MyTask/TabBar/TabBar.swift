//
//  TabBar.swift
//  MyTask
//
//  Created by Danil on 11.08.2024.
//

import UIKit
import SnapKit

final class CustomTabBarController: UIViewController, FloatingTabBarDelegate {

    private var currentViewController: UIViewController?
    private var floatingTabBar: FloatingTabBar!
    private var router: Routes
    typealias Routes = Closable & ToDoRoute & OnProgressRoute & CompleteRoute & SettingsRoute & ToDoRoute

    override func viewDidLoad() {
        super.viewDidLoad()
        floatingTabBar = FloatingTabBar(items: ["todo", "inprogress", "todo", "settings"])
        floatingTabBar.delegate = self
        view.addSubview(floatingTabBar)
        floatingTabBar.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.leading.equalTo(view).offset(20)
            make.trailing.equalTo(view).inset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
        }
        loadViewController(at: 0)
    }

    init(router: Routes) {
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func tabBar(didSelectItemAt index: Int) {
        loadViewController(at: index)
    }

    private func loadViewController(at index: Int) {
        print(index)
        currentViewController?.willMove(toParent: nil)
        currentViewController?.view.removeFromSuperview()
        currentViewController?.removeFromParent()
        let newViewController: UIViewController
        switch index {
        case 0:
            newViewController = router.openToDoStartScreen()
        case 1:
            newViewController = router.openOnProgressStartScreen()
        case 2:
            newViewController = router.openCompleteStartScreen()
        case 3:
            newViewController = router.openSettingsStartScreen()
        default:
            return
        }
        addChild(newViewController)
        view.insertSubview(newViewController.view, belowSubview: floatingTabBar)
        newViewController.view.frame = view.bounds
        newViewController.didMove(toParent: self)
        currentViewController = newViewController
    }
}
