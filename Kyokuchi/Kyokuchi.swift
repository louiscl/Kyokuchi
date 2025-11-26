//
//  Kyokuchi.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

@main
struct KyokuchiApp: App {
    var body: some Scene {
        WindowGroup {
            LandingView()
        }
        .modelContainer(for: [Habit.self])
    }
}
