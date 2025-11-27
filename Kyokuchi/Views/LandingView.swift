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

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: Renshu.self, configurations: config)

    // Seed preview with sample data
    let sampleRenshus = [
        Renshu(title: "Morning Meditation", subtitle: "11 minutes of mindfulness", imageName: "shukan-0"),
        Renshu(title: "Exercise", subtitle: "30 minutes of movement", imageName: "shukan-1"),
        Renshu(title: "Read", subtitle: "Read for 20 minutes", imageName: "shukan-2"),
        Renshu(title: "Journal", subtitle: "Write in gratitude journal", imageName: "shukan-3"), // shukan-3 doesn't exist
    ]

    for renshu in sampleRenshus {
        container.mainContext.insert(renshu)
    }

    return LandingView()
        .modelContainer(container)
}

// #Preview {
//    LandingView()
//        .modelContainer(for: Renshu.self, inMemory: true)
// }
