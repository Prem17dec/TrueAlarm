//
//  DetailsDisplayView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct DetailsDisplayView: View {
    let alarm: TrueAlarm
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(alarm.category.rawValue) - \(alarm.title)")
                .font(.headline)
                .lineLimit(1)
            
            if let notes = alarm.notes, !notes.isEmpty {
                Text(notes)
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .lineLimit(1)
            }
        }
    }
}
