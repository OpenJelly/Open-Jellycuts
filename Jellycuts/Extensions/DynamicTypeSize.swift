//
//  DynamicTypeSize.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

extension DynamicTypeSize: CustomStringConvertible, Identifiable {
    public var id: String {
        return self.description
    }
    
    public var description: String {
        switch self {
        case .xSmall:
            return "X Small"
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        case .xLarge:
            return "X Large"
        case .xxLarge:
            return "XX Large"
        case .xxxLarge:
            return "XXX Large"
        case .accessibility1:
            return "Accessibility 1"
        case .accessibility2:
            return "Accessibility 2"
        case .accessibility3:
            return "Accessibility 3"
        case .accessibility4:
            return "Accessibility 4"
        case .accessibility5:
            return "Accessibility 5"
        @unknown default:
            return "Unknown"
        }
    }
    
    init(id: String) {
        switch id {
        case "X Small":
            self = .xSmall
        case "Small":
            self = .small
        case "Medium":
            self = .medium
        case "Large":
            self = .large
        case "X Large":
            self = .xLarge
        case "XX Large":
            self = .xxLarge
        case "XXX Large":
            self = .xxxLarge
        case "Accessibility 1":
            self = .accessibility1
        case "Accessibility 2":
            self = .accessibility2
        case "Accessibility 3":
            self = .accessibility3
        case "Accessibility 4":
            self = .accessibility4
        case "Accessibility 5":
            self = .accessibility5
        default:
            self = .medium
        }
    }
}
