//
//  TrueAlarmApp.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

@main
struct TrueAlarmApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            AlarmListView()
        }
    }
}
