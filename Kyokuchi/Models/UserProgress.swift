//
//  UserProgress.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

@Model
class UserProgress {
    var totalXP: Int
    var cognitiveXP: Int
    var physicalXP: Int
    var capitalXP: Int
    var skillsXP: Int
    var cognitiveLevel: Int
    var physicalLevel: Int
    var capitalLevel: Int
    var skillsLevel: Int
    var productiveDays: [Date]

    init() {
        totalXP = 0
        cognitiveXP = 0
        physicalXP = 0
        capitalXP = 0
        skillsXP = 0
        cognitiveLevel = 1
        physicalLevel = 1
        capitalLevel = 1
        skillsLevel = 1
        productiveDays = []
    }

    func xp(for category: Category) -> Int {
        switch category {
        case .cognitive: return cognitiveXP
        case .physical: return physicalXP
        case .capital: return capitalXP
        case .skills: return skillsXP
        }
    }

    func setXP(_ xp: Int, for category: Category) {
        switch category {
        case .cognitive: cognitiveXP = xp
        case .physical: physicalXP = xp
        case .capital: capitalXP = xp
        case .skills: skillsXP = xp
        }
    }

    func level(for category: Category) -> Int {
        switch category {
        case .cognitive: return cognitiveLevel
        case .physical: return physicalLevel
        case .capital: return capitalLevel
        case .skills: return skillsLevel
        }
    }

    func setLevel(_ level: Int, for category: Category) {
        switch category {
        case .cognitive: cognitiveLevel = level
        case .physical: physicalLevel = level
        case .capital: capitalLevel = level
        case .skills: skillsLevel = level
        }
    }
}
