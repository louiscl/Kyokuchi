//
//  XPManager.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

class XPManager {
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    // MARK: - Level Calculation
    
    /// Calculate XP required for a given level
    static func xpRequired(for level: Int) -> Int {
        guard level > 1 else { return 10 }
        let xp = 10.0 * pow(1.2, Double(level - 1))
        return Int(xp.rounded())
    }
    
    /// Calculate level from current XP
    static func calculateLevel(from xp: Int) -> Int {
        guard xp >= 10 else { return 1 }
        var level = 1
        var requiredXP = 10.0
        var currentXP = Double(xp)
        
        while currentXP >= requiredXP {
            level += 1
            currentXP -= requiredXP
            requiredXP *= 1.2
        }
        
        return level
    }
    
    // MARK: - XP Awarding
    
    func awardXP(for renshu: Renshu, date: Date = Date()) throws {
        // Get or create UserProgress
        let progress = try getOrCreateUserProgress()
        
        // Calculate XP for each category
        var totalXPAwarded = 0
        for category in renshu.categories {
            let xpForCategory = Int(Double(renshu.baseXP) * category.multiplier)
            let currentXP = progress.xp(for: category)
            let newXP = currentXP + xpForCategory
            progress.setXP(newXP, for: category)
            
            // Update level
            let newLevel = XPManager.calculateLevel(from: newXP)
            progress.setLevel(newLevel, for: category)
            
            totalXPAwarded += xpForCategory
        }
        
        // Update total XP
        progress.totalXP += totalXPAwarded
        
        // Create completion record
        let completion = Completion(
            renshuID: renshu.id,
            completedAt: date,
            xpAwarded: totalXPAwarded,
            categories: renshu.categories
        )
        context.insert(completion)
        
        // Check for productive day
        try checkProductiveDay(for: date)
    }
    
    // MARK: - XP Deduction
    
    func deductXP(for renshu: Renshu, date: Date = Date()) throws {
        // Find the completion record for this renshu on this date
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        let renshuID = renshu.id
        
        let descriptor = FetchDescriptor<Completion>(
            predicate: #Predicate<Completion> { completion in
                completion.renshuID == renshuID
            },
            sortBy: [SortDescriptor(\.completedAt, order: .reverse)]
        )
        
        // Filter by date manually after fetch (SwiftData predicate limitation)
        let allCompletions = try context.fetch(descriptor)
        let completion = allCompletions.first { completion in
            completion.completedAt >= startOfDay && completion.completedAt < endOfDay
        }
        
        guard let completion = completion else {
            return // No completion found to deduct
        }
        
        // Get UserProgress
        let progress = try getOrCreateUserProgress()
        
        // Deduct XP for each category
        var totalXPDeducted = 0
        for category in renshu.categories {
            let xpForCategory = Int(Double(renshu.baseXP) * category.multiplier)
            let currentXP = progress.xp(for: category)
            let newXP = max(0, currentXP - xpForCategory) // Don't go below 0
            progress.setXP(newXP, for: category)
            
            // Update level
            let newLevel = XPManager.calculateLevel(from: newXP)
            progress.setLevel(newLevel, for: category)
            
            totalXPDeducted += xpForCategory
        }
        
        // Update total XP
        progress.totalXP = max(0, progress.totalXP - totalXPDeducted)
        
        // Delete completion record
        context.delete(completion)
        
        // Recheck productive day (might need to remove it)
        try checkProductiveDay(for: date)
    }
    
    // MARK: - Productive Day
    
    private func checkProductiveDay(for date: Date) throws {
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)
        let endOfDay = calendar.date(byAdding: .day, value: 1, to: startOfDay)!
        
        // Get all completions (SwiftData predicate limitation with dates)
        let descriptor = FetchDescriptor<Completion>()
        let allCompletions = try context.fetch(descriptor)
        
        // Filter by date manually
        let completions = allCompletions.filter { completion in
            completion.completedAt >= startOfDay && completion.completedAt < endOfDay
        }
        let dailyXP = completions.reduce(0) { $0 + $1.xpAwarded }
        
        // Get or create settings
        let settingsDescriptor = FetchDescriptor<Settings>()
        let settings: Settings
        if let existing = try? context.fetch(settingsDescriptor).first {
            settings = existing
        } else {
            settings = Settings()
            context.insert(settings)
        }
        
        let progress = try getOrCreateUserProgress()
        
        // Check if day is productive
        let isProductive = dailyXP >= settings.productiveDayThreshold
        
        // Add or remove from productive days
        if isProductive {
            // Add if not already there
            if !progress.productiveDays.contains(where: { calendar.isDate($0, inSameDayAs: date) }) {
                progress.productiveDays.append(startOfDay)
            }
        } else {
            // Remove if present
            progress.productiveDays.removeAll { calendar.isDate($0, inSameDayAs: date) }
        }
    }
    
    // MARK: - Helpers
    
    private func getOrCreateUserProgress() throws -> UserProgress {
        let descriptor = FetchDescriptor<UserProgress>()
        if let progress = try? context.fetch(descriptor).first {
            return progress
        } else {
            let progress = UserProgress()
            context.insert(progress)
            return progress
        }
    }
}

