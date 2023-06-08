//
//  AppearanceManager.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI
import HydrogenReporter

class AppearanceManager: ObservableObject {
    enum ColorEnvironment: String, CaseIterable, Identifiable {
        var id: Self { self }

        case system
        case light
        case dark
        
        func swiftUIColorScheme() -> ColorScheme? {
            switch self {
            case .system:
                return nil
            case .light:
                return .light
            case .dark:
                return .dark
            }
        }
    }
    
    @Published var accentColor: AccentColor = .blue
    @Published var colorScheme: ColorEnvironment = .system
    @Published var preferredDynamicTypeSize: DynamicTypeSize = .medium
    
    public static let shared: AppearanceManager = AppearanceManager()
    
    private init() {
        accentColor = PreferenceManager.getAccentColor()
        colorScheme = PreferenceManager.getColorScheme()
        preferredDynamicTypeSize = PreferenceManager.getPreferredTypeSize()
    }
}

// MARK: Appearance Preference Setters
extension AppearanceManager {
    func setAccentColor(color: AccentColor) throws {
        accentColor = color
        try PreferenceManager.saveAccentColor(color: accentColor)
    }
        
    func setAppEnvironment(scheme: ColorEnvironment) {
        self.colorScheme = scheme
        PreferenceManager.saveColorScheme(scheme: scheme)
    }

    func saveDynamicTypeSize(typeSize: DynamicTypeSize) {
        PreferenceManager.savePreferredTypeSize(size: typeSize)
    }
}
