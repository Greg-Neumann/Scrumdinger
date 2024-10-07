//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI
import OSLog

struct ScrumsView: View {
    let scrums: [DailyScrum]
    var body: some View {
        NavigationStack{
            //
            // There is no need to pass an explicit identifier for the List control as
            // the Identifiable protocol on the DailyScrum struct implicitely addresses this
            //
            List(scrums){ scrum in
                Logger.viewCycle.debug("Scrum \(scrum.title)")
                //
                return NavigationLink(destination: DetailView(scrum: scrum)){
                    CardView(scrum: scrum)
                       
                } .listRowBackground(scrum.theme.mainColour)
            }
            //
            // This modified on the List element is cascaded to the chiled NavigationStack item
            //
            .navigationTitle("Daily Scrums")
            //
            .toolbar{
                Button(action: {}){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("New Scrum")
            }
        }
    }
}

#Preview {
    //
    // Pass in mock data
    //
    ScrumsView(scrums: DailyScrum.sampleData)
}
extension Logger {
    /// Using your bundle identifier is a great way to ensure a unique identifier.
    private static var subsystem = Bundle.main.bundleIdentifier!

    /// Logs the view cycles like a view that appeared.
    static let viewCycle = Logger(subsystem: subsystem, category: "viewcycle")

    /// All logs related to tracking and analytics.
    static let statistics = Logger(subsystem: subsystem, category: "statistics")
}
