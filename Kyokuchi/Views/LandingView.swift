//
//  LandingView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

struct LandingView: View {
    @Environment(\.modelContext) private var context
    @Query(sort: \Habit.createdAt) private var habits: [Habit]

    var body: some View {
        NavigationStack {
            ZStack {
                // Background image
                Image("bg design v2")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()

                // Content
                VStack(alignment: .leading, spacing: 15) {
                    // Header
                    Text("KYOKUCHI")
                        .font(.largeTitle.bold())
                        .padding(.horizontal)
                        .padding(.top, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .foregroundColor(Color.textPrimary)
                    // .tint(Color.textPrimary) // how does this work?

                    Image("subheader symbol")
                        .resizable()
                        .scaledToFit()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, 60)

                    // Text("Every day")
                    //     .font(.callout)
                    //     .foregroundColor(.secondary)
                    //     .padding(.horizontal)
                    //     .frame(maxWidth: .infinity, alignment: .center)

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(Array(habits.enumerated()), id: \.element.id) { index, habit in
                                HabitCard(habit: habit, index: index)
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.top)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .safeAreaPadding(.top)
                .padding(.top, 60)
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        AddHabitView()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Habit.self, configurations: config)
    
    // Seed preview with sample data
    let sampleHabits = [
        Habit(title: "Morning Meditation", subtitle: "10 minutes of mindfulness"),
        Habit(title: "Exercise", subtitle: "30 minutes of movement"),
        Habit(title: "Read", subtitle: "Read for 20 minutes"),
        Habit(title: "Journal", subtitle: "Write in gratitude journal")
    ]
    
    for habit in sampleHabits {
        container.mainContext.insert(habit)
    }
    
    return LandingView()
        .modelContainer(container)
}

//#Preview {
//    LandingView()
//        .modelContainer(for: Habit.self, inMemory: true)
//}
