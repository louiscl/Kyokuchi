//
//  Completion.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

@Model
class Completion {
    var renshuID: UUID
    var completedAt: Date
    var xpAwarded: Int
    var categoriesData: [String] // Store as strings for SwiftData

    var categories: [Category] {
        get {
            categoriesData.compactMap { Category(rawValue: $0) }
        }
        set {
            categoriesData = newValue.map { $0.rawValue }
        }
    }

    init(renshuID: UUID, completedAt: Date, xpAwarded: Int, categories: [Category]) {
        self.renshuID = renshuID
        self.completedAt = completedAt
        self.xpAwarded = xpAwarded
        categoriesData = categories.map { $0.rawValue }
    }
}
