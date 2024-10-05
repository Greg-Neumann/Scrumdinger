//
//  TrailingIconLabelStyle.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI

struct TrailingIconLabelStyle: LabelStyle {
    //
    // makeBody is called for each label instance
    //
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
        }
}
extension LabelStyle where Self == TrailingIconLabelStyle {
    //
    // Extension creates a static property called trainingIcon
    //
    static var trailingIcon: Self {Self()}
}
