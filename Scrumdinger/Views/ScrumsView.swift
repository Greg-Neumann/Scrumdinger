//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI
import OSLog

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingNewScrumView: Bool = false
    //
    var body: some View {
        NavigationStack{
            //
            // There is no need to pass an explicit identifier for the List control as
            // the Identifiable protocol on the DailyScrum struct implicitely addresses this
            //
            // $scrum binds to the padded-in bound value
            //
            List($scrums){ $scrum in
                Logger.viewCycle.debug("Scrum \(scrum.title)")
                //
                return NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                       
                } .listRowBackground(scrum.theme.mainColour)
            }
            //
            // This modified on the List element is cascaded to the chiled NavigationStack item
            //
            .navigationTitle("Daily Scrums")
            //
            .toolbar{
                Button(action: {
                    isPresentingNewScrumView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
        .sheet(isPresented: $isPresentingNewScrumView){
            NewScrumSheet(scrums: $scrums, isPresentingNewScrumSheet: $isPresentingNewScrumView)
            
        }
    }
}

#Preview {
    //
    // Pass in mock data
    //
    ScrumsView(scrums: .constant(DailyScrum.sampleData))
}
extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}
