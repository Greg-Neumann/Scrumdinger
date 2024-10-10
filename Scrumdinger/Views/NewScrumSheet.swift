//
//  NewScrumSheet.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 10/10/2024.
//

import SwiftUI

struct NewScrumSheet: View {
    @State private var newScrum = DailyScrum.emptyScrum
    @Binding var scrums: [DailyScrum]
    @Binding var isPresentingNewScrumSheet: Bool
    //
    var body: some View {
        NavigationStack{
            DetailEditView(scrum: $newScrum)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction){
                        Button("Dismiss"){
                            isPresentingNewScrumSheet = false
                        }
                    }
                    ToolbarItem(placement: .confirmationAction){
                        Button("Add"){
                            scrums.append((newScrum))
                            isPresentingNewScrumSheet = false
                        }
                        
                    }
                }
        }
    }
}

#Preview {
    NewScrumSheet(scrums:.constant(DailyScrum.sampleData), isPresentingNewScrumSheet: .constant(true))
}
