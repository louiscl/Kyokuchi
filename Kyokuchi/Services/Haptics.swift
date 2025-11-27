//
//  Haptics.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import CoreHaptics
import UIKit

enum Haptics {
    // MARK: - Original Methods

    static func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    static func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }

    static func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }

    // MARK: - Stronger Haptic Options

    /// Strong success haptic - combines notification with impact for a more pronounced feel
    static func strongSuccess() {
        let notificationGenerator = UINotificationFeedbackGenerator()
        notificationGenerator.notificationOccurred(.success)

        // Add a heavy impact for extra emphasis
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            let impactGenerator = UIImpactFeedbackGenerator(style: .heavy)
            impactGenerator.impactOccurred()
        }
    }

    /// Duolingo-style success - double tap pattern
    static func duolingoSuccess() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()

        // First tap
        generator.impactOccurred(intensity: 0.8)

        // Second tap after short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            generator.impactOccurred(intensity: 1.0)
        }
    }

    /// Strong completion haptic - triple pattern for emphasis
    static func strongCompletion() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()

        // Triple tap pattern
        generator.impactOccurred(intensity: 0.7)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.08) {
            generator.impactOccurred(intensity: 0.9)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.16) {
            generator.impactOccurred(intensity: 1.0)
        }
    }

    /// Custom haptic with maximum intensity
    static func maxImpact() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred(intensity: 1.0)
    }

    /// Soft to strong crescendo pattern
    static func crescendo() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()

        let intensities: [CGFloat] = [0.3, 0.5, 0.7, 0.9, 1.0]
        let delays: [TimeInterval] = [0.0, 0.05, 0.10, 0.15, 0.20]

        for (index, intensity) in intensities.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + delays[index]) {
                generator.impactOccurred(intensity: intensity)
            }
        }
    }

    /// CoreHaptics custom pattern - most control and strongest option
    static func customStrong() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var engine: CHHapticEngine?
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine error: \(error)")
            return
        }

        // Create a strong, sharp haptic event
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.8)

        let event = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity, sharpness],
            relativeTime: 0
        )

        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error)")
        }
    }

    /// CoreHaptics double-tap pattern (Duolingo-style with CoreHaptics)
    static func customDoubleTap() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }

        var engine: CHHapticEngine?
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("Haptic engine error: \(error)")
            return
        }

        // First tap - strong
        let intensity1 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 0.8)
        let sharpness1 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.7)
        let event1 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity1, sharpness1],
            relativeTime: 0
        )

        // Second tap - stronger
        let intensity2 = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1.0)
        let sharpness2 = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0.9)
        let event2 = CHHapticEvent(
            eventType: .hapticTransient,
            parameters: [intensity2, sharpness2],
            relativeTime: 0.1
        )

        do {
            let pattern = try CHHapticPattern(events: [event1, event2], parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            print("Failed to play pattern: \(error)")
        }
    }
}
