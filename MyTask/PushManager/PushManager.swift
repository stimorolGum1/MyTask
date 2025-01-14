//
//  PushManager.swift
//  MyTask
//
//  Created by Danil on 02.12.2024.
//

import UserNotifications
import UIKit
import CoreData

// MARK: - PushManager

final class PushManager {
    
    // MARK: - Properties
    
    private static let center = UNUserNotificationCenter.current()
    
    init() {}
    
    // MARK: - Request Permission for push
    
    func requestPermission(completion: @escaping (String?) -> Void) {
        PushManager.center.requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                UserDefaults.standard.set(true, forKey: UserDefaultsEnum.isPushEnabled.rawValue)
                completion(nil)
            } else {
                if error == nil {
                    completion(Localization.checkPushSettings)
                }
            }
        }
    }
    
    // MARK: - Disable Permission for push
    
    func disablePermission() {
        PushManager.center.removeAllPendingNotificationRequests()
        PushManager.center.removeAllDeliveredNotifications()
        UserDefaults.standard.set(false, forKey: UserDefaultsEnum.isPushEnabled.rawValue)
    }
    
    // MARK: - Schedule push
    
    func scheduleNotification(task: String, dueDate: Date, id: NSManagedObjectID) {
        let content = UNMutableNotificationContent()
        content.title = Localization.contentTitle
        content.body = Localization.contentBodyLeftSide + " " + "\(task)" + " " + Localization.contentBodyRightSide
        content.sound = .default
        content.badge = NSNumber(value: 1)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: max(dueDate.timeIntervalSinceNow, 1), repeats: false)
        let request = UNNotificationRequest(identifier: id.uriRepresentation().absoluteString, content: content, trigger: trigger)
        PushManager.center.add(request) { error in
            if let error = error {
                print("error: \(error.localizedDescription)")
            } else {
                print("Added on id \(id.uriRepresentation().absoluteString)")
            }
        }
    }
    
    // MARK: - Fetch pending push
    
    func fetchPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        PushManager.center.getPendingNotificationRequests { requests in
            completion(requests)
        }
    }
    // MARK: - Remove pending push by ID
    
    func removeFromNotification(id: NSManagedObjectID) {
        let identifier = id.uriRepresentation().absoluteString
        PushManager.center.getPendingNotificationRequests { requests in
            if requests.first(where: { $0.identifier == identifier }) != nil {
                PushManager.center.removePendingNotificationRequests(withIdentifiers: [identifier])
                print("Notification with ID \(identifier) successfully removed.")
            } else {
                print("No scheduled notification found with ID \(identifier).")
            }
        }
    }
    
    func removeAllPendingNotifications() {
        PushManager.center.removeAllPendingNotificationRequests()
    }

    // MARK: - Update push by ID
    
    func updatePushNotification(task: String, dueDate: Date, id: NSManagedObjectID) {
        self.removeFromNotification(id: id)
        self.scheduleNotification(task: task, dueDate: dueDate, id: id)
    }
}
