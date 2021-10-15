//
//  LocalNotificationManager.swift
//  todo
//
//  Created by Enes N KENDİRCİ on 15.10.2021.
//

import Foundation
import UserNotifications


protocol NotificationManager {
    func createNotification(id: Int, title: String, endDate: Date)
}

class LocalNotificationManager: NotificationManager {
    static let shared = LocalNotificationManager()
    private init() {}
    let notificationContent = UNMutableNotificationContent()
    
    func createNotification(id: Int, title: String, endDate: Date) {
        notificationContent.title = title
        notificationContent.body = "To-Do history is over."
        notificationContent.sound = .default
        
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: endDate)
        let dateTrigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let identifer = String(id)
        
        let request = UNNotificationRequest(identifier: identifer, content: notificationContent, trigger: dateTrigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}
