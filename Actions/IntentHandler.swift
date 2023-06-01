//
//  IntentHandler.swift
//  Actions
//
//  Created by Taylor Lineman on 6/1/23.
//

import Intents

class IntentHandler: INExtension {
    
    override func handler(for intent: INIntent) -> Any {
        switch intent {
        case is GetShortcutIntent:
            return GetShortcutHandler()
        default:
            fatalError("No handler for this intent")
        }
    }
    
}
