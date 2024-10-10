//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 10/10/2024.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection : Theme
    var body: some View {
        Picker("Theme", selection: $selection){
            //
            // Loop over all possible themes from the enumeration
            //
            ForEach(Theme.allCases){ theme in
                ThemeView(theme: theme)
                    .tag(theme) // adds the name of the theme to the picker 🤔
            }
        }
        //
        // This cause the picker to use the navigation stack
        //
        .pickerStyle(.navigationLink)
    }
}

#Preview {
    //
    // The passed-forward value is immutable
    //
    ThemePicker(selection: .constant(.periwinkle))
}
