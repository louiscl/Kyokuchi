//
//  Color+Theme.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI

extension Color {
    // Gray scale colors (light to dark)
    // Gray100 = #F8F9FA (lightest)
    // Gray200 = #E9ECEF
    // Gray300 = #DEE2E6
    // Gray400 = #CED4DA
    // Gray500 = #ADB5BD
    // Gray600 = #6C757D
    // Gray700 = #495057
    // Gray800 = #343A40
    // Gray900 = #212529 (darkest)

    static let theme100 = Color("Gray100")
    static let theme200 = Color("Gray200")
    static let theme300 = Color("Gray300")
    static let theme400 = Color("Gray400")
    static let theme500 = Color("Gray500")
    static let theme600 = Color("Gray600")
    static let theme700 = Color("Gray700")
    static let theme800 = Color("Gray800")
    static let theme900 = Color("Gray900")

    // Semantic color mappings (optional - customize based on your app's needs)
    // You can add semantic names that map to your gray scale
    static let appBackground = Color.theme400 // Gray400 = #CED4DA
    static let cardBackground = Color.theme200
    static let borderColor = Color.theme300
    static let textPrimary = Color.theme900
    static let textSecondary = Color.theme600
    static let textTertiary = Color.theme500
}
