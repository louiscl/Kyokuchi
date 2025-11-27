//
//  RenshuCard.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI
import UIKit

struct RenshuCard: View {
    @Bindable var renshu: Renshu

    private var backgroundImageName: String {
        // Try to load the image, if it fails, use default
        if UIImage(named: renshu.imageName) != nil {
            return renshu.imageName
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
                Text(renshu.title)
                    .font(.headline)
                    .foregroundColor(Color.theme100)

                Text(renshu.subtitle)
                    .font(.subheadline)
                    .foregroundColor(Color.theme100.opacity(0.8))
            }
            .padding()

            // Completion overlay
            if renshu.isCompletedToday {
                ZStack {
                    // Dark overlay
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.black.opacity(0.45))

                    // Completion text
                    VStack(spacing: 4) {
                        Text("完")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                        Text("了")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 120)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(radius: 6)
        .animation(.spring(response: 0.25, dampingFraction: 0.7), value: renshu.isCompletedToday)
        .onTapGesture {
            let wasCompleted = renshu.isCompletedToday
            
            // Toggle completion: set to today's date if not completed, nil if already completed
            if renshu.isCompletedToday {
                renshu.lastCompletedDate = nil
            } else {
                renshu.lastCompletedDate = Date()
            }

            // Play sound and haptic only when completing (not uncompleting)
            if !wasCompleted && renshu.isCompletedToday {
                Sound.playCompletion()
                Haptics.strongCompletion()
            }
        }
    }
}

