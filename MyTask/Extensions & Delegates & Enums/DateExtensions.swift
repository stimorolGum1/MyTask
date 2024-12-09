//
//  StringExtensions.swift
//  MyTask
//
//  Created by Danil on 03.11.2024.
//

import Foundation

// MARK: - Date convert extentsion

extension Date {
    func convertToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter.string(from: self)
    }
}
