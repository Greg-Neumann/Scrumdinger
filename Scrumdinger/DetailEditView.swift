//
//  DetailEditView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 08/10/2024.
//

import SwiftUI

struct DetailEditView: View {
    //
    // Encapsulate State as only accessible inside this current View
    //
    @State private var scrum : DailyScrum = DailyScrum.emptyScrum
    @State private var newAttendeeName = ""

    //
    
    var body: some View {
        Form {
            Section(header: Text("Meeting Info")){
                TextField("Title", text: $scrum.title)
                HStack{
                    //
                    // A step of 1 in the Slider limits the allowed values to
                    // being integer
                    //
                    Slider(value: $scrum.lengthInMinutesAsDouble, in: 5...30,step: 1){
                        //
                        // The Text view won’t appear onscreen, but VoiceOver
                        // uses it to identify the purpose of the slider.
                        //
                        Text("Length")
                    }
                    .accessibilityValue("\(scrum.lengthInMinutes) minutes")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                        .accessibilityHidden(true)
                }
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees){ attendee in
                    Text(attendee.name)
                }
                .onDelete {indices in
                    scrum.attendees.remove(atOffsets: indices)
                }
                HStack{
                    TextField("New Attendee", text: $newAttendeeName)
                    Button(action: {
                        //
                        // Add an animation block that creates a new attendee and appends the new attendee to the attendees array.
                        //
                        withAnimation{
                            let attendee = DailyScrum.Attendee(name: newAttendeeName)
                            scrum.attendees.append(attendee)
                            newAttendeeName = "" // also
                        }
                    }){
                        Image(systemName: "plus.circle.fill")
                            .accessibilityLabel("Add Attendee")
                    }
                    .disabled(newAttendeeName.isEmpty)
                }
            }
        }
    }
}

#Preview {
    DetailEditView()
}
