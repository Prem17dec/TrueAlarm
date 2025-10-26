//
//  AlarmCreationView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct AlarmCreationView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AlarmListViewModel
    
    @State private var selectedDate = Date().addingTimeInterval(3600) // Default to 1 hour from now
    @State private var title: String = ""
    @State private var notes: String = ""
    @State private var selectedCategory: TrueAlarmCategory = .custom
    
    var body: some View {
        NavigationView {
            Form {
                Section("Alarm Details") {
                    DatePicker("When to Ring", selection: $selectedDate)
                    // Supports natural language input if user types specific terms
                    TextField("Title (e.g., Send Report, Call Doctor)", text: $title)
                    
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TrueAlarmCategory.allCases, id: \.self) { category in
                            Text(category.rawValue)
                        }
                    }
                }
                
                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("New True Alarm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        saveAlarm()
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
    
    private func saveAlarm() {
        let newAlarm = TrueAlarm(
            date: selectedDate,
            title: title,
            notes: notes,
            category: selectedCategory
        )
        viewModel.addAlarm(alarm: newAlarm)
    }
}
