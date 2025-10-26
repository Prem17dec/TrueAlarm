//
//  TrueAlarm.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import Foundation

struct TrueAlarm: Identifiable, Codable {
    let id = UUID()
    var date: Date
    var title: String
    var notes: String?
    var category: TrueAlarmCategory
    var isEnabled: Bool = true
    var actionLink: URL?
    
    init(date: Date, title: String, notes: String? = nil, category: TrueAlarmCategory, actionLink: URL? = nil) {
        self.date = date
        self.title = title
        self.notes = notes
        self.category = category
        self.actionLink = actionLink
    }
}
