//
//  TrueAlarmCategory.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import Foundation

enum TrueAlarmCategory: String, CaseIterable, Codable {
    case travel = "✈️ Travel"
    case bills = "💰 Bills"
    case messages = "💬 Messages"
    case health = "🩺 Health"
    case studyWork = "📚 Study & Work"
    case custom = "✨ Custom"
    
    // Helper for notification category ID, used by the NotificationManager
    var notificationCategoryID: String {
        return "TrueAlarm.\(self.rawValue.replacingOccurrences(of: " ", with: ""))"
    }
}
