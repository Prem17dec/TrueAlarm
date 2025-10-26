//
//  AlarmListView.swift
//  TrueAlarm
//
//  Created by Prem Kumar Nallamothu on 10/26/25.
//

import SwiftUI

struct AlarmListView: View {
    
    @StateObject var viewModel = AlarmListViewModel()
    @State private var showingAddAlarmSheet = false
    
    var body: some View {
        NavigationView {
            // Implements the 'Clean timeline view' feature
            List {
                
                ForEach(viewModel.alarms) { alarm in
                    AlarmRowView(alarm: alarm, toggleAction: {
                        // Action passed back to the ViewModel for business logic
                        viewModel.toggleAlarm(alarm: alarm)
                    })
                }
                .onDelete(perform: viewModel.deleteAlarm)
            }
            .navigationTitle("True Alarm 🔔")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddAlarmSheet = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showingAddAlarmSheet) {
                AlarmCreationView(viewModel: viewModel)
            }
        }
    }
}
