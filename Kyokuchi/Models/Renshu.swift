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

    init(title: String, subtitle: String, imageName: String = "shukan-0") {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        createdAt = .now
        lastCompletedDate = nil
    }
    
    /// Computed property that checks if the renshu was completed today (using device local timezone)
    var isCompletedToday: Bool {
        guard let date = lastCompletedDate else { return false }
        return Calendar.current.isDateInToday(date)
    }
}

