//
//  PreferenceManager.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI
import HydrogenReporter

struct PreferenceManager { }

// MARK: Project Sort
extension PreferenceManager {
    static func getProjectSort() -> ProjectSort {
        return ProjectSort(rawValue: SharedDataStorageManager.defaults.string(forKey: PreferenceValues.projectSort.rawValue) ?? "") ?? .recentlyOpened
    }
    
    static func saveProjectSort(sort: ProjectSort) {
        SharedDataStorageManager.defaults.set(sort.rawValue, forKey: PreferenceValues.projectSort.rawValue)
    }
}

// MARK: Haptics
extension PreferenceManager {
    static func getHapticsEnabled() -> Bool {
        return SharedDataStorageManager.defaults.bool(forKey: PreferenceValues.haptics.rawValue)
    }
    
    static func saveHaptics(enabled: Bool) {
        print(enabled)
        SharedDataStorageManager.defaults.set(enabled, forKey: PreferenceValues.haptics.rawValue)
    }
}

// MARK: Preferred Type Size
extension PreferenceManager {
    static func getPreferredTypeSize() -> DynamicTypeSize {
        if let size = SharedDataStorageManager.defaults.string(forKey: PreferenceValues.typeSize.rawValue) {
            return DynamicTypeSize.init(id: size)
        }
        
        return .medium
    }
    
    static func savePreferredTypeSize(size: DynamicTypeSize) {
        SharedDataStorageManager.defaults.set(size.description, forKey: PreferenceValues.typeSize.rawValue)
    }
}

// MARK: Environment Color Scheme
extension PreferenceManager {
    static func getColorScheme() -> AppearanceManager.ColorEnvironment {
        if let scheme = SharedDataStorageManager.defaults.string(forKey: PreferenceValues.colorScheme.rawValue),
           let colorScheme = AppearanceManager.ColorEnvironment.init(rawValue: scheme) {
            return colorScheme
        }
        
        return .system
    }
    
    static func saveColorScheme(scheme: AppearanceManager.ColorEnvironment) {
        SharedDataStorageManager.defaults.set(scheme.rawValue, forKey: PreferenceValues.colorScheme.rawValue)
    }
}

// MARK: Accent Color
extension PreferenceManager {
    static func getAccentColor() -> AccentColor {
        if let colorData = SharedDataStorageManager.defaults.data(forKey: PreferenceValues.accentColor.rawValue),
           let color = try? PropertyListDecoder().decode(AccentColor.self, from: colorData) {
            return color
        }
        return .custom(color: .accentColor)
    }
    
    static func saveAccentColor(color: AccentColor) throws {
        let colorData: Data = try PropertyListEncoder().encode(color)
        SharedDataStorageManager.defaults.set(colorData, forKey: PreferenceValues.accentColor.rawValue)
    }
}

// MARK: Get In App Browser
extension PreferenceManager {
    static func getInAppBrowser() -> Bool {
        return SharedDataStorageManager.defaults.bool(forKey: PreferenceValues.inAppBrowser.rawValue)
    }
    
    static func saveInAppBrowser(shouldUse: Bool) {
        SharedDataStorageManager.defaults.set(shouldUse, forKey: PreferenceValues.inAppBrowser.rawValue)
    }
}
