//
//  AppIconManager.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

struct AppIconManager {
    enum StandardIcons: String, CaseIterable, Identifiable {
        case primary = "AppIcon"

        var id: String { self.rawValue }
        
        var name: String {
            switch self {
            case .primary:
                return "Default"
            }
        }
    }
        
    static func getAppIconName(for bundleName: String) -> String {
        if let icon = StandardIcons(rawValue: bundleName) {
            return icon.name
        }
        
        return "Default"
    }
}
