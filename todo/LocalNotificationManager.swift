//
//  LocalNotificationManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 15.10.2021.
//

import Foundation
import UserNotifications


protocol NotificationManager {
    func createNotification(id: UUID, title: String, endDate: Date)
}

class LocalNotificationManager: NotificationManager {
    static let shared = LocalNotificationManager()
    private init() {}
    let notificationContent = UNMutableNotificationContent()
    
    func createNotification(id: UUID, title: String, endDate: Date) {
        setContent(title)
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: endDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let identifer = id.uuidString
        let request = UNNotificationRequest(identifier: identifer, content: notificationContent, trigger: dateTrigger)
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
    private func setContent(_ title: String){
        notificationContent.title = title
        notificationContent.body = NotificationLanguageEnum.body.rawValue.localized()
        notificationContent.sound = .default
    }
}
