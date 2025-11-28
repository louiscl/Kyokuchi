//
//  Category.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation

enum Category: String, Codable, CaseIterable {
    case cognitive = "Cognitive"
    case physical = "Physical"
    case capital = "Capital"
    case skills = "Skills"
    
    var multiplier: Double {
        switch self {
        case .cognitive: return 1.0
        case .physical: return 1.0
        case .capital: return 2.0
        case .skills: return 1.5
        }
    }
}

