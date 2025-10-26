//
//  AlarmToggleView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct AlarmToggleView: View {
    let isEnabled: Bool
    let action: () -> Void
    
    var body: some View {
        // We use .constant(isEnabled) because the actual state change is handled
        // by the ViewModel, triggered by the onTapGesture.
        Toggle("", isOn: .constant(isEnabled))
            .labelsHidden()
            .tint(.red)
            .onTapGesture {
                action()
            }
    }
}
