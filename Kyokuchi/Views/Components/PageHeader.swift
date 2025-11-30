//
//  PageHeader.swift
//  Kyokuchi
//
//  Created by L L on 25/11/2025.
//

import SwiftUI

struct PageHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.largeTitle.bold())
            .foregroundColor(Color.textPrimary)
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.horizontal)
            .padding(.top, LayoutConstants.headerTopPadding)
    }
}
