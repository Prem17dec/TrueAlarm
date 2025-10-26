//
//  NotificationManager.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import UserNotifications
import UIKit

// MARK: - Notification Manager Class
class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    static let shared = NotificationManager()
    private let notificationCenter = UNUserNotificationCenter.current()
    
    private override init() {
        super.init()
        notificationCenter.delegate = self
        // Request authorization and configure categories on initialization
        requestAuthorization()
        configureNotificationCategories()
    }
    
    // MARK: - Authorization & Configuration
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Notification authorization granted.")
            } else if let error = error {
                print("Notification authorization error: \(error.localizedDescription)")
            }
        }
    }
    
    private func configureNotificationCategories() {
        // 1. Bills Category with a 'Quick Pay' action
        let quickPayAction = UNNotificationAction(identifier: "QUICK_PAY_ACTION", title: "Quick Pay 💳", options: [.foreground])
        let billsCategory = UNNotificationCategory(
            identifier: TrueAlarmCategory.bills.notificationCategoryID,
            actions: [quickPayAction], intentIdentifiers: [], options: .customDismissAction
        )
        
        // 2. Messages Category with 'Call' and 'Message' actions
        let callAction = UNNotificationAction(identifier: "CALL_ACTION", title: "Call Person 📞", options: [.foreground])
        let messageAction = UNNotificationAction(identifier: "MESSAGE_ACTION", title: "Open Message App 💬", options: [.foreground])
        let messagesCategory = UNNotificationCategory(
            identifier: TrueAlarmCategory.messages.notificationCategoryID,
            actions: [callAction, messageAction], intentIdentifiers: [], options: .customDismissAction
        )
        
        notificationCenter.setNotificationCategories([billsCategory, messagesCategory])
    }
    
    // MARK: - Scheduling
    
    func scheduleAlarm(alarm: TrueAlarm) {
        // If the alarm is disabled, ensure any pending notification is cancelled
        guard alarm.isEnabled else {
            cancelAlarm(alarmID: alarm.id)
            return
        }
        
        let content = UNMutableNotificationContent()
        content.title = alarm.title
        content.body = "\(alarm.category.rawValue): \(alarm.notes ?? "Time to take action!")"
        content.categoryIdentifier = alarm.category.notificationCategoryID
        // Note: You must add a file named 'TrueAlarm_Ring.mp3' (or .wav/.aiff) to your Xcode project to use this custom sound
        content.sound = UNNotificationSound(named: UNNotificationSoundName("TrueAlarm_Ring.mp3"))
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: alarm.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: alarm.id.uuidString, content: content, trigger: trigger)
        
        notificationCenter.add(request) { error in
            if let error = error {
                print("Error scheduling alarm \(alarm.title): \(error.localizedDescription)")
            } else {
                print("Scheduled: \(alarm.title) for \(alarm.date)")
            }
        }
    }
    
    func cancelAlarm(alarmID: UUID) {
        notificationCenter.removePendingNotificationRequests(withIdentifiers: [alarmID.uuidString])
        print("Cancelled alarm with ID: \(alarmID)")
    }
    
    // MARK: - UNUserNotificationCenterDelegate (Action Handling)
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case "QUICK_PAY_ACTION":
            // Placeholder: Attempts to open a specific banking app scheme
            if let url = URL(string: "bankingapp://pay") {
                UIApplication.shared.open(url)
            }
            
        case "CALL_ACTION":
            // Placeholder: Attempts to open the Phone app
            if let url = URL(string: "tel://1-555-555-5555") {
                UIApplication.shared.open(url)
            }
            
        case "MESSAGE_ACTION":
            // Placeholder: Attempts to open a messaging app
            if let url = URL(string: "whatsapp://") {
                UIApplication.shared.open(url)
            }
            
        default:
            break
        }
        
        completionHandler()
    }
    
    // Critical: Allows the notification to present itself even when the app is foregrounded
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
}
