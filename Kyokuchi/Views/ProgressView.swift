//
//  ProgressView.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftData
import SwiftUI

struct ProgressView: View {
    @Query private var progressList: [UserProgress]

    var userProgress: UserProgress? {
        progressList.first
    }

    var body: some View {
        ZStack {
            // Background image
            Image("bg design v3")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea(.container, edges: .top)
            VStack(alignment: .leading, spacing: 15) {
                // Header
                PageHeader(title: "Progress")
                // Content - respects safe area automatically
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
                                    .background(Color.cardBackground)
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
                            .background(Color.cardBackground)
                            .cornerRadius(12)
                        } else {
                            Text("No progress data yet")
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding()
                }
            }
            .safeAreaPadding(.top)
            .padding(.top, LayoutConstants.coreVstackPadding)
        }
    }
}
