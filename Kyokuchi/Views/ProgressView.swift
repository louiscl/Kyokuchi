//
//  ProgressView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI
import SwiftData

struct ProgressView: View {
    @Query private var progressList: [UserProgress]
    
    var userProgress: UserProgress? {
        progressList.first
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                if let progress = userProgress {
                    // Total XP
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Total XP")
                            .font(.headline)
                        Text("\(progress.totalXP)")
                            .font(.largeTitle.bold())
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme200)
                    .cornerRadius(12)
                    
                    // Category Levels
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Category Levels")
                            .font(.headline)
                        
                        ForEach(Category.allCases, id: \.self) { category in
                            HStack {
                                Text(category.rawValue)
                                    .font(.subheadline)
                                Spacer()
                                VStack(alignment: .trailing, spacing: 4) {
                                    Text("Level \(progress.level(for: category))")
                                        .font(.headline)
                                    Text("\(progress.xp(for: category)) XP")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding()
                            .background(Color.theme200)
                            .cornerRadius(8)
                        }
                    }
                    
                    // Productive Days
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Productive Days")
                            .font(.headline)
                        Text("\(progress.productiveDays.count)")
                            .font(.title.bold())
                        Text("Days that met the daily XP threshold")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.theme200)
                    .cornerRadius(12)
                } else {
                    Text("No progress data yet")
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
        .navigationTitle("Progress")
    }
}

