//
//  Theme.swift
//  Scrumdinger
//
//  Created by Greg Neumann on 04/10/2024.
//

import SwiftUI
//
// SwiftUI defines the Color structure used in accentColour
//
enum Theme: String, CaseIterable, Identifiable {
    case bubblegum
    case buttercup
    case indigo
    case lavender
    case magenta
    case navy
    case orange
    case oxblood
    case periwinkle
    case poppy
    case purple
    case seafoam
    case sky
    case tan
    case teal
    case yellow
    //
    // Identifiable mandates existance of 'id' which is declared as being the name of the theme (part of the enum)
    //
    var id: String { name }
    
    var accentColour: Color{
        //
        // accentColour maintains a high visual colour contrast between the theme colour and the text
        // (which is set to the accentColour)
        //
        switch self {
        case .bubblegum, .buttercup, .lavender, .orange, .periwinkle, .poppy, .seafoam, .sky, .tan, .teal, .yellow : return .black
        case .indigo, .magenta,.navy, .oxblood, .purple : return .white
        }
    }
    var mainColour: Color {
        // use the enumeration's raw value from the Asset Catalogue
        Color(rawValue)
    }
    var name: String {
        // capitalize the enumeration value
        rawValue.capitalized
    }
    
}
