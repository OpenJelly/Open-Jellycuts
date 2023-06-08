//
//  AccentColor.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

enum AccentColor: CaseIterable, Identifiable, Codable, Equatable {
    static var allCases: [AccentColor] = [.red, .pink, .orange, .yellow, .green, .teal, .blue, .cyan, .indigo, .purple, .brown, .gray]
    var id: String { self.name }

    case red
    case pink
    case orange
    case yellow
    case green
    case teal
    case blue
    case cyan
    case indigo
    case purple
    case mint
    case brown
    case gray
    case custom(color: Color)
    
    var name: String {
        switch self {
        case .red:
            return "Rose Red"
        case .pink:
            return "Pink"
        case .orange:
            return "Tangerine"
        case .yellow:
            return "Bumble Bee"
        case .green:
            return "Evergreen"
        case .teal:
            return "Turqoise"
        case .blue:
            return "Sapphire"
        case .cyan:
            return "Periwinkle"
        case .indigo:
            return "Blueberry"
        case .purple:
            return "Amethyst"
        case .mint:
            return "Miraculous Mint"
        case .brown:
            return "Dirt Brown"
        case .gray:
            return "Stone"
        case .custom(_):
            return "Custom"
        }
    }
    
    var color: Color {
        switch self {
        case .red:
            return .red
        case .pink:
            return .pink
        case .orange:
            return .orange
        case .yellow:
            return .yellow
        case .green:
            return .green
        case .teal:
            return .teal
        case .blue:
            return .blue
        case .cyan:
            return .cyan
        case .indigo:
            return .indigo
        case .purple:
            return .purple
        case .mint:
            return .mint
        case .brown:
            return .brown
        case .gray:
            return .gray
        case .custom(let color):
            return color
        }
    }
    
    static func == (lhs: AccentColor, rhs: AccentColor) -> Bool {
        return lhs.id == rhs.id
    }
}
