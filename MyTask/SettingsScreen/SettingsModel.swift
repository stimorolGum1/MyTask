//
//  SettingsModel.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation

// MARK: - SettingsModel

struct SettingsModel {
    let settings = [Localization.push, Localization.storage, Localization.extras]
    let items = [[SettingsItem(name: Localization.enableNotifications, switchIsEnabled: true, isSwitchEnableFor: UserDefaults.standard.bool(forKey: UserDefaultsEnum.isPushEnabled.rawValue))],
                 [SettingsItem(name: Localization.wipeStorage, switchIsEnabled: false, isSwitchEnableFor: nil)],
                 [SettingsItem(name: Localization.aboutApp, switchIsEnabled: false, isSwitchEnableFor: nil)]]
}

// MARK: - SettingsItem

struct SettingsItem {
    let name: String
    let switchIsEnabled: Bool
    let isSwitchEnableFor: Bool?
}
