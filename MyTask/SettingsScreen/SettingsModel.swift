//
//  SettingsModel.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation

struct SettingsModel {
    let settings = [Localization.push, Localization.storage, Localization.extras]
    let items = [[SettingsItem(name: Localization.enableNotifications, switchIsEnabled: true)],
                 [SettingsItem(name: Localization.wipeStorage, switchIsEnabled: false)],
                 [SettingsItem(name: Localization.aboutApp, switchIsEnabled: false)]]
}

struct SettingsItem {
    let name: String
    let switchIsEnabled: Bool
}
