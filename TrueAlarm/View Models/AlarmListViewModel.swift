//
//  AlarmListViewModel.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import Foundation
import Combine

class AlarmListViewModel: ObservableObject {
    
    // The source of truth for all alarms, published to update SwiftUI views
    @Published var alarms: [TrueAlarm] = []
    
    private let manager = NotificationManager.shared
    
    init() {
        loadInitialData()
    }
    
    // MARK: - Data Management (CRUD)
    
    func addAlarm(alarm: TrueAlarm) {
        alarms.append(alarm)
        // Sort by date to maintain the 'Clean timeline view' feature
        alarms.sort { $0.date < $1.date }
        manager.scheduleAlarm(alarm: alarm)
        // Production Note: Add persistence logic (SwiftData/Core Data) here
    }
    
    func toggleAlarm(alarm: TrueAlarm) {
        guard let index = alarms.firstIndex(where: { $0.id == alarm.id }) else { return }
        
        alarms[index].isEnabled.toggle()
        let updatedAlarm = alarms[index]
        
        if updatedAlarm.isEnabled {
            manager.scheduleAlarm(alarm: updatedAlarm)
        } else {
            manager.cancelAlarm(alarmID: updatedAlarm.id)
        }
    }
    
    func deleteAlarm(offsets: IndexSet) {
        offsets.forEach { index in
            manager.cancelAlarm(alarmID: alarms[index].id)
        }
        
        alarms.remove(atOffsets: offsets)
        // Production Note: Update persistence here
    }
    
    // MARK: - Dummy Data
    
    private func loadInitialData() {
        let oneDayFromNow = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let threeDaysFromNow = Calendar.current.date(byAdding: .day, value: 3, to: Date())!
        let nextHour = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        
        let dummyAlarms = [
            TrueAlarm(date: oneDayFromNow, title: "Flight Check-In", notes: "24-hour check-in alert", category: .travel),
            TrueAlarm(date: threeDaysFromNow, title: "Credit Card Payment", notes: "Quick Pay linked!", category: .bills),
            TrueAlarm(date: nextHour, title: "Call Mom", notes: "One-tap open phone", category: .messages),
            TrueAlarm(date: Date().addingTimeInterval(120), title: "Take Morning Meds", notes: "Synced with HealthKit", category: .health)
        ]
        
        self.alarms = dummyAlarms.sorted { $0.date < $1.date }
        
        dummyAlarms.forEach { manager.scheduleAlarm(alarm: $0) }
    }
}
