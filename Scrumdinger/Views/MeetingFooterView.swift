//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 10/10/2024.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    var skipAction: ()-> Void
    private var speakerNumber: Int? {
        //
        // A speaker is marked as completed when they have done their turn
        //
        guard let index = speakers.firstIndex(where: {!$0.isCompleted}) else { return nil }
        return index + 1
    }
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy{$0.isCompleted}
    }
    private var speakerText : String {
        guard let speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel("Next Speaker") // stop Voiceover announcing the forward.fill image
                    // Voiceover automatically voices the trait 'Button' at the end of the label stated above
                }
            }
        }.padding([.bottom, .horizontal])
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
}
