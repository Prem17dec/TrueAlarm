//
//  AppDelegate.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import UIKit

// The AppDelegate is needed to initialize the NotificationManager early
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Accessing the shared manager ensures it's initialized and requests permissions
        _ = NotificationManager.shared
        return true
    }
}

