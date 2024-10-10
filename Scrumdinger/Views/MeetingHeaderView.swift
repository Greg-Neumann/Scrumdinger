//
//  MeetingHeaderView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 10/10/2024.
//

import SwiftUI

struct MeetingHeaderView: View {
    let secondsElapsed: Int
    let secondsRemaining: Int
    let theme : Theme
    //
    // private computed
    //
    private var totalSeconds: Int {
        secondsElapsed + secondsRemaining
    }
    private var progress: Double {
        guard totalSeconds > 0 else { return 1 }
        return Double(secondsElapsed) / Double(totalSeconds)
    }
    private var minutesRemaining: Int {
        secondsRemaining / 60
    }
    //
    var body: some View {
        VStack {
            ProgressView(value: progress)
            //
            //  use the custom style to draw a background view in either black or white around the ProgressView to give the view more visual emphasis.
            //
                .progressViewStyle(ScrumProgressViewStyle(theme: theme))
        }
        HStack {
            VStack(alignment: .leading) {
                Text("Seconds Elapsed")
                    .font(.caption)
                Label("\(secondsElapsed)", systemImage: "hourglass.tophalf.fill")
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Seconds Remaining")
                    .font(.caption)
                Label("\(secondsRemaining)", systemImage:"hourglass.bottomhalf.fill")
                    .labelStyle(.trailingIcon)
            }
        }
        .accessibilityElement(children: .ignore) // ignore the default accessibility tooling to add explicit custom
        .accessibilityLabel("Time Remaining")
        //
        // Because VoiceOver users don’t have the visual reference of the progress view or progress ring, calculate the conversion from seconds to minutes and surface the most relevant data—the minutes remaining.
        //
        .accessibilityValue("\(minutesRemaining) minutes")
        .padding([.top, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MeetingHeaderView(secondsElapsed: 60, secondsRemaining: 180, theme: .bubblegum)
      
}
