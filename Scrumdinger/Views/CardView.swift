//
//  CardView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI

struct CardView: View {
    let scrum: DailyScrum
    var body: some View {
        VStack(alignment: .leading){
            Text(scrum.title)
                .font(.headline)
            //
            // Voiceover to announce the title text followed by 'heading'
            //
                .accessibilityAddTraits(.isHeader)
            //
            Spacer()
            HStack{
                Label("\(scrum.attendees.count)", systemImage: "person.3")
                    .accessibilityLabel("\(scrum.attendees.count) attendees")
                Spacer()
                Label("\(scrum.lengthInMinutes)", systemImage: "clock")
                //
                // 😱 Omitting the following leading '.' leads to an infinite loop in this VStack
                // with no compiler error - shocking!
                //
                    .accessibilityLabel("\(scrum.lengthInMinutes) minutes meeting")
                    .labelStyle(.trailingIcon) // custom label style
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(scrum.theme.accentColour)
    }
}

#Preview {
    //
    // define values that are consumed in the CardView whilst preparing this preview
    //
    @Previewable @State var scrum = DailyScrum.sampleData[0]
    return CardView(scrum:scrum)
        .background(scrum.theme.mainColour)
}

