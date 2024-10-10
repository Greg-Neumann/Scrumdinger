//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 07/10/2024.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    //
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView(scrum: $scrum)) {
                    //
                    // This Navigation Link adds a gesture recognizer so that the row can be
                    // tapped to navigate to the child screen
                    //
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                //
                // Combine the (above) Label and text elements into one accessibility prompt
                // It is Voiced as "Length, 10 minutes". Without this, VoiceOver users would
                // have to swipe between the two visual elements
                //
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name) // capitalised name
                        .padding(4)
                        .background(Color.accentColor)
                        .foregroundColor(scrum.theme.accentColour)
                        .background(scrum.theme.mainColour)
                        .cornerRadius(10).cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")){
             ForEach(scrum.attendees) { attendee in
                 Label(attendee.name, systemImage: "person")
                }
            }
            Section(header: Text("History")){
                if scrum.history.isEmpty {
                    Label("No Meetings yet",systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history){history in
                    HStack{
                        Image(systemName: "Calendar")
                        Text(history.date, style: .date)
                    }
                }
            }
        }
        .navigationTitle(scrum.title)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        //
        // Use a modal Sheet in detail edit mode
        // Modal views remove users from the main navigation flow of the app. Use modality for short, self-contained tasks
        //
        .sheet(isPresented: $isPresentingEditView){
            NavigationStack{
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done"){
                                isPresentingEditView = false
                                scrum = editingScrum
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum:  .constant( DailyScrum.sampleData[1]))
    }
   
}
