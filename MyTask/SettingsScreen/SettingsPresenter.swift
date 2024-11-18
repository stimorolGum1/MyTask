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
    func enablePush()
    func wipeStorage()
    func openAboutScreen()
}

// MARK: - Presenter Implementation

class SettingsPresenter {
    
    // MARK: - Properties
    
    private weak var view: SettingsViewControllerProtocol?
    private let model: SettingsModel
    private let router: Routes
    typealias Routes = Closable & AboutScreenRoute
    
    // MARK: - Initializer
    
    init(view: SettingsViewControllerProtocol?, model: SettingsModel, router: Routes) {
        self.view = view
        self.model = model
        self.router = router
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
    
    func enablePush() {
        // in progress
    }
    
    func wipeStorage() {
        StorageManager.shared.wipeStorage()
    }
    
    func openAboutScreen() {
        router.openAboutScreen()
    }
}
