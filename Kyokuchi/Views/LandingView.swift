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
    @Query(sort: \Renshu.createdAt) private var renshus: [Renshu]

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

                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(renshus) { renshu in
                                RenshuCard(renshu: renshu)
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
                    HStack {
                        NavigationLink {
                            ProgressView()
                        } label: {
                            Image(systemName: "chart.bar.fill")
                                .font(.title2)
                        }
                        
                        NavigationLink {
                            SettingsView()
                        } label: {
                            Image(systemName: "gearshape.fill")
                                .font(.title2)
                        }
                        
                        NavigationLink {
                            RenshuHub()
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }
            }
        }
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
    
    return LandingView()
        .modelContainer(container)
}
