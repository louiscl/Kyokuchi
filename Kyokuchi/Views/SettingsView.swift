//
//  SettingsView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.modelContext) private var context    // access model db and assign variable context
    @Query private var settings: [Settings]     // fetches all Settings objects from the database
    
    @State private var threshold: Int = 30
    
    var body: some View {
        Form {
            Section("Productive Day") {
                Stepper("Threshold: \(threshold) XP", value: $threshold, in: 1...1000)
                Text("A day is considered productive when total daily XP exceeds this threshold.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .navigationTitle("Settings")
        .onAppear {
            if let existingSettings = settings.first {
                threshold = existingSettings.productiveDayThreshold
            }
        }
        .onChange(of: threshold) { oldValue, newValue in
            saveSettings()
        }
    }
    
    private func saveSettings() {
        if let existingSettings = settings.first {
            existingSettings.productiveDayThreshold = threshold
        } else {
            let newSettings = Settings(productiveDayThreshold: threshold)
            context.insert(newSettings)
        }
    }
}

