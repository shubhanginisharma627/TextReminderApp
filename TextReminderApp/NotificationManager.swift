//
//  NotificationManager.swift
//  TextReminderApp
//
//  Created by Shubhangini Sharma on 17/11/23.
//

import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()

    func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, _ in
            if granted {
                print("Notification permission granted.")
            }
        }
    }

    func scheduleNotifications(with texts: [String]) {
        guard !texts.isEmpty else { return }

        let content = UNMutableNotificationContent()
        content.title = "Reminder"
        content.body = texts.randomElement() ?? "Your text"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 7200, repeats: true)

        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error)")
            }
        }
    }
}

