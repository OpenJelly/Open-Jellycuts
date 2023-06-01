//
//  GetShortcutHandler.swift
//  Actions
//
//  Created by Taylor Lineman on 6/1/23.
//

import Intents
import HydrogenReporter

class GetShortcutHandler: NSObject, GetShortcutIntentHandling {
    func handle(intent: GetShortcutIntent) async -> GetShortcutIntentResponse {
        guard let defaults = UserDefaults(suiteName: Constants.suiteName) else {
            LOG("Unable to create shared User Defaults", level: .error)
            let response = GetShortcutIntentResponse(code: .failure, userActivity: .none)
            response.error = "No Defaults Available"
            return response
        }
        
        guard let name = SharedDataStorageManager.defaults.string(forKey: DefaultsKeys.lastSignedShortcutNameKey) else {
            return GetShortcutIntentResponse(code: .noName, userActivity: nil)
        }
        
        guard let data = SharedDataStorageManager.defaults.data(forKey: DefaultsKeys.lastSignedShortcutDataKey) else {
            return GetShortcutIntentResponse(code: .noData, userActivity: .none)
        }
        
        let response = GetShortcutIntentResponse(code: .success, userActivity: .none)
        let file = INFile(data: data, filename: name, typeIdentifier: "com.apple.shortcut")
        response.file = file

        return response
    }
}
