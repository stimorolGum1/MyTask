//
//  SettingsModel.swift
//  MyTask
//
//  Created by Danil on 01.09.2024.
//

import Foundation

struct SettingsModel {
    let settings = ["Push notifications", "Storage", "Extras"]
    let items = [[SettingsItem(name: "Enable notifications", switchIsEnabled: true)],
                 [SettingsItem(name: "Wipe Storage", switchIsEnabled: false)],
                 [SettingsItem(name: "Enable password", switchIsEnabled: true),
                  SettingsItem(name: "About app", switchIsEnabled: false)]]
}

struct SettingsItem {
    let name: String
    let switchIsEnabled: Bool
}
