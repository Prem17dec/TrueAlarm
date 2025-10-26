//
//  TimeDisplayView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct TimeDisplayView: View {
    let date: Date
    let isEnabled: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date, style: .time)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(isEnabled ? .primary : .secondary)
            
            Text(date, style: .date)
                .font(.caption)
                .foregroundColor(isEnabled ? .gray : .secondary.opacity(0.7))
        }
    }
}
