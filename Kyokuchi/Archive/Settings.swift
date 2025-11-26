//
//  Settings.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        Form {
            Section("Appearance") {
                Toggle("Dark Mode", isOn: .constant(true))
            }
            Section("Notifications") {
                Toggle("Daily Reminder", isOn: .constant(false))
            }
            Section("About") {
                Text("Version 0.1.0")
            }
        }
        .navigationTitle("Settings")
    }
}
