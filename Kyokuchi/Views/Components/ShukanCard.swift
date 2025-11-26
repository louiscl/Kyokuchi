//
//  ShukanCard.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI
import UIKit

struct HabitCard: View {
    @Bindable var habit: Habit
    let index: Int
    
    private var backgroundImageName: String {
        let imageName = "shukan-\(index)"
        // Try to load the image, if it fails, use default
        if UIImage(named: imageName) != nil {
            return imageName
        } else {
            return "shukan-0"
        }
    }

    var body: some View {
        ZStack(alignment: .leading) {
            // Background image - fills entire card
            Image(backgroundImageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // Dark overlay to improve text readability
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black.opacity(0.4))
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                Text(habit.title)
                    .font(.headline)
                    .foregroundColor(Color.theme100)

                Text(habit.subtitle)
                    .font(.subheadline)
                    .foregroundColor(Color.theme100.opacity(0.8))
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 6)
        .scaleEffect(habit.isCompletedToday ? 0.97 : 1.0)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: habit.isCompletedToday)
        .onTapGesture {
            habit.isCompletedToday.toggle()
            Haptics.success()
        }
    }
}
