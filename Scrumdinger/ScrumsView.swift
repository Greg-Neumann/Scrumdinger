//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        List(scrums){ scrum in
            CardView(scrum: scrum)
                .listRowBackground(scrum.theme.mainColour)
        }
    }
}

#Preview {
    //
    // Pass in mock data
    //
    ScrumsView(scrums: DailyScrum.sampleData)
}
