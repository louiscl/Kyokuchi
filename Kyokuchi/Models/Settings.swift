//
//  Settings.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import Foundation
import SwiftData

@Model
class Settings {
    var productiveDayThreshold: Int
    
    init(productiveDayThreshold: Int = 30) {
        self.productiveDayThreshold = productiveDayThreshold
    }
}

