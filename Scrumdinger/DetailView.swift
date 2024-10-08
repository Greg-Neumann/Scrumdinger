//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 07/10/2024.
//

import SwiftUI

struct DetailView: View {
    let scrum: DailyScrum
    
    @State private var isPresentingEditView = false
    
    var body: some View {
        List{
            Section(header: Text("Meeting Info")){
                NavigationLink(destination: MeetingView()) {
                    //
                    // This Navigation Link adds a gesture recognizer so that the row can be
                    // tapped to navigate to the child screen
                    //
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "Clock")
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
        }
        .navigationTitle(scrum.title)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
            }
        }
        //
        // Use a modal Sheet in detail edit mode
        // Modal views remove users from the main navigation flow of the app. Use modality for short, self-contained tasks
        //
        .sheet(isPresented: $isPresentingEditView){
            NavigationStack{
                DetailEditView()
                    .navigationTitle(scrum.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancel"){
                                isPresentingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(scrum:   DailyScrum.sampleData[1])
    }
   
}
