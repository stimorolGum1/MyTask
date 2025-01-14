//
//  SettingsPresenter.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation

// MARK: - Presenter Protocol

protocol SettingsPresenterProtocol: AnyObject {
    func numberOfSection() -> Int
    func dataOfSection(section: Int) -> String
    func numberAtRowInSection(section: Int) -> Int
    func dataOfRowInSection(section: Int, row: Int) -> SettingsItem
    func controlPush(enable: Bool, completion: @escaping () -> Void)
    func wipeStorage()
    func openAboutScreen()
}

// MARK: - Presenter Implementation

final class SettingsPresenter {
    
    // MARK: - Properties
    
    private weak var view: SettingsViewControllerProtocol?
    private let model: SettingsModel
    private let router: Routes
    private let pushManager: PushManager
    typealias Routes = Closable & AboutScreenRoute
    
    
    // MARK: - Initializer
    
    init(view: SettingsViewControllerProtocol?, model: SettingsModel, router: Routes, pushManager: PushManager) {
        self.view = view
        self.model = model
        self.router = router
        self.pushManager = pushManager
    }
}

// MARK: - SettingsPresenterProtocol

extension SettingsPresenter: SettingsPresenterProtocol {
    func numberOfSection() -> Int {
        return model.settings.count
    }
    
    func dataOfSection(section: Int) -> String {
        return model.settings[section]
    }
    
    func numberAtRowInSection(section: Int) -> Int {
        return model.items[section].count
    }
    
    func dataOfRowInSection(section: Int, row: Int) -> SettingsItem {
        return model.items[section][row]
    }
    
    func controlPush(enable: Bool, completion: @escaping () -> Void) {
        if enable {
            pushManager.requestPermission { [weak self] status in
                DispatchQueue.main.async {
                    self?.view?.showAlert(message: status!, withCancel: false, completion: nil)
                    completion()
                }
            }
        } else {
            pushManager.disablePermission()
        }
    }
    
    func wipeStorage() {
        StorageManager.shared.wipeStorage()
        pushManager.removeAllPendingNotifications()
    }
    
    func openAboutScreen() {
        router.openAboutScreen()
    }
}
