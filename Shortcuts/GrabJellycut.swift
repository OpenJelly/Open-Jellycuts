//
//  GrabJellycut.swift
//  Shortcuts
//
//  Created by Taylor Lineman on 5/31/23.
//

import Foundation
import AppIntents

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct GrabJellycut: AppIntent, CustomIntentMigratedAppIntent {
    enum GrabJellycutError: LocalizedError {
        case invalidName
        case invalidData
        
        var errorDescription: String? {
            switch self {
            case .invalidData:
                return "The data for the most recent shortcut is invalid"
            case .invalidName:
                return "The name for the most recent shortcut is invalid"
            }
        }
        
        var recoverySuggestion: String? {
            return "Please try re-exporting the last Jellycut. If that does not work please restart your device."
        }
    }
    
    static let intentClassName = "GrabJellycutIntent"

    static var title: LocalizedStringResource = "Grab Jellycut"
    static var description = IntentDescription("Gets the last exported Jellycut")

    static var parameterSummary: some ParameterSummary {
        Summary("Grab Jellycut")
    }

    func perform() async throws -> some IntentResult & ReturnsValue<IntentFile> {
        guard let name = SharedDataStorageManager.defaults.string(forKey: DefaultsKeys.lastSignedShortcutNameKey) else {
            throw GrabJellycutError.invalidName
        }
        guard let data = SharedDataStorageManager.defaults.data(forKey: DefaultsKeys.lastSignedShortcutDataKey) else {
            throw GrabJellycutError.invalidData
        }

        return .result(value: IntentFile(data: data, filename: name))
    }
}


