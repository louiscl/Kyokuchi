//
//  AddShukanView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

struct AddHabitView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Query(sort: \Habit.createdAt) private var habits: [Habit]

    @State private var title = ""
    @State private var subtitle = ""

    var body: some View {
        Form {
            Section("Habit Details") {
                TextField("Title", text: $title)
                TextField("Subtitle", text: $subtitle)
            }
            
            Section("Existing Habits") {
                if habits.isEmpty {
                    Text("No habits yet")
                        .foregroundColor(.secondary)
                } else {
                    ForEach(habits) { habit in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(habit.title)
                                .font(.headline)
                            Text(habit.subtitle)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: deleteHabits)
                }
            }
        }
        .navigationTitle("New Habit")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("Save") {
                    let habit = Habit(title: title, subtitle: subtitle)
                    context.insert(habit)
                    dismiss()
                }
                .disabled(title.isEmpty)
            }

            ToolbarItem(placement: .topBarLeading) {
                Button("Cancel") { dismiss() }
            }
        }
    }
    
    private func deleteHabits(at offsets: IndexSet) {
        for index in offsets {
            context.delete(habits[index])
        }
    }
}
