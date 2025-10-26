//
//  AlarmRowView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct AlarmRowView: View {
    let alarm: TrueAlarm
    let toggleAction: () -> Void
    
    var body: some View {
        HStack {
            // 1. Time Display Component
            TimeDisplayView(date: alarm.date, isEnabled: alarm.isEnabled)
            
            Divider()
            
            // 2. Details Component
            DetailsDisplayView(alarm: alarm)
            
            Spacer()
            
            // 3. Toggle Component
            AlarmToggleView(isEnabled: alarm.isEnabled, action: toggleAction)
        }
        .padding(.vertical, 4)
        // Dim the entire row if disabled
        .opacity(alarm.isEnabled ? 1.0 : 0.5)
    }
}
