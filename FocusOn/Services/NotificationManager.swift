//
//  NotificationManager.swift
//  FocusOn
//
//  Created by Alexandra Ivanova on 20/10/2023.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    private var components = DateComponents()
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if granted {
                print("Successfully authorized notifications!")
                self.scheduleMorningNotification()
                self.scheduleNoonNotification()
                self.scheduleAfternoonNotification()
                self.scheduleEveningNotification()
            } else if let error = error {
                print("Error for notification authorization: \(error.localizedDescription)")
            } else {
                print("Notification authorization denied by the user.")
            }
        }
    }
    
    private func scheduleMorningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Start your day!"
        content.body = "Set up a goal for today!"
        content.sound = .default
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        components.hour = 8
        components.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
    }
    
    private func scheduleNoonNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Task Progress"
        content.body = "Don't forget to update your task progress for today!"
        content.sound = .default
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        components.hour = 12
        components.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
    }
    
    private func scheduleAfternoonNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Task Progress"
        content.body = "Don't forget to update your task progress for today!"
        content.sound = .default
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 20, repeats: false)
        
        components.hour = 16
        components.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
    }
    
    private func scheduleEveningNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Goal Progress"
        content.body = "Make sure to complete your goal today!"
        content.sound = .default
        
//        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 25, repeats: false)
        
        components.hour = 18
        components.minute = 00
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
                    if let error = error {
                        print("Error scheduling notification: \(error.localizedDescription)")
                    }
                }
    }
    
    func cancelNotification() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
    }
}

