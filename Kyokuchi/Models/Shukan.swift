//
//  Shukan.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

@Model
class Habit {
    @Attribute(.unique) var id: UUID
    var title: String
    var subtitle: String
    var createdAt: Date
    var isCompletedToday: Bool

    init(title: String, subtitle: String) {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        createdAt = .now
        isCompletedToday = false
    }
}
