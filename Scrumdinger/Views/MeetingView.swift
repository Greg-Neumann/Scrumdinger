//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    //
    // This view owns the source of truth for this object below
    // @StateObject ties the ScrumTimer, which is an ObservableObject, to the MeetingView life cycle.
    //
    @StateObject var scrumTimer =  ScrumTimer()
    //
    private var player: AVPlayer {AVPlayer.sharedDingPlayer}
    //
    fileprivate func startScrum() {
        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees:     scrum.attendees)
        //
        // Always play audio from the start
        //
        scrumTimer.speakerChangedAction = {
            player.seek(to: .zero)
            player.play() // play the file!
        }
        scrumTimer.startScrum()
    }
    
    fileprivate func endScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }
    
    var body: some View {
        ZStack {
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                Circle()
                    .strokeBorder(lineWidth: 24)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
            .padding() // default padding
            .foregroundColor(scrum.theme.accentColour)
            //
            // Lifecyle calls
            //
            .onAppear {
                startScrum()
            }
            .onDisappear {
                endScrum()
            }
            //
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
