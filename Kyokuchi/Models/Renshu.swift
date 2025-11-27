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
    var isCompletedToday: Bool

    init(title: String, subtitle: String, imageName: String = "shukan-0") {
        id = UUID()
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        createdAt = .now
        isCompletedToday = false
    }
}

