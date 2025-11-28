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
        self.totalXP = 0
        self.cognitiveXP = 0
        self.physicalXP = 0
        self.capitalXP = 0
        self.skillsXP = 0
        self.cognitiveLevel = 1
        self.physicalLevel = 1
        self.capitalLevel = 1
        self.skillsLevel = 1
        self.productiveDays = []
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

