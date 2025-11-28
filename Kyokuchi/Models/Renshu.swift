//
//  Renshu.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

@Model
class Renshu {
    @Attribute(.unique) var id: UUID
    var title: String
    var subtitle: String
    var imageName: String
    var createdAt: Date
    var lastCompletedDate: Date?
    var baseXP: Int
    var categoriesData: [String] // Store as strings for SwiftData
    
    var categories: [Category] {
        get {
            categoriesData.compactMap { Category(rawValue: $0) }
        }
        set {
            categoriesData = newValue.map { $0.rawValue }
        }
    }

    init(title: String, subtitle: String, imageName: String = "shukan-0", baseXP: Int = 10, categories: [Category] = [.cognitive]) {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.baseXP = baseXP
        self.categoriesData = categories.map { $0.rawValue }
        createdAt = .now
        lastCompletedDate = nil
    }
    
    /// Computed property that checks if the renshu was completed today (using device local timezone)
    var isCompletedToday: Bool {
        guard let date = lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(date)
    }
}

