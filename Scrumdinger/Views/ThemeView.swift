//
//  ThemeView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 10/10/2024.
//

import SwiftUI

struct ThemeView: View {
    let theme : Theme
    var body: some View {
        Text(theme.name)
            .padding(4)
            .frame(maxWidth: .infinity) // fill to left and right margins
            .background(theme.mainColour)
            .foregroundColor(theme.accentColour)
            .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

#Preview {
    ThemeView(theme: .buttercup)
}
