//
//  MainTabView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            // Home Tab
            NavigationStack {
                LandingView()
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            // Renshū Hub Tab
            NavigationStack {
                RenshuHub()
            }
            .tabItem {
                Label("Renshū", systemImage: "plus.circle.fill")
            }

            // Progress Tab
            NavigationStack {
                ProgressView()
            }
            .tabItem {
                Label("Progress", systemImage: "chart.bar.fill")
            }

            // Settings Tab
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gearshape.fill")
            }
        }
        .preferredColorScheme(.light)
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(
        for: Renshu.self, UserProgress.self, Completion.self, Settings.self,
        configurations: config
    )

    // Seed sample data
    let sampleRenshu1 = Renshu(
        title: "Morning Meditation",
        subtitle: "10 minutes",
        imageName: "shukan-0",
        baseXP: 10,
        categories: [.cognitive]
    )
    let sampleRenshu2 = Renshu(
        title: "Exercise",
        subtitle: "30 minutes",
        imageName: "shukan-1",
        baseXP: 15,
        categories: [.physical]
    )
    let sampleRenshu3 = Renshu(
        title: "Learn Swift",
        subtitle: "1 hour",
        imageName: "shukan-2",
        baseXP: 20,
        categories: [.skills]
    )

    container.mainContext.insert(sampleRenshu1)
    container.mainContext.insert(sampleRenshu2)
    container.mainContext.insert(sampleRenshu3)

    return MainTabView()
        .modelContainer(container)
}
