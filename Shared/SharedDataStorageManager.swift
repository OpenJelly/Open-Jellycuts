//
//  SharedDataStorageManager.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import Foundation
import KeychainSwift
import HydrogenReporter

class SharedDataStorageManager {
    static var keychain: KeychainSwift {
        let keychain = KeychainSwift()
        keychain.accessGroup = Constants.keychainAccessGroup
        keychain.synchronizable = true
        
        return keychain
    }
    
    static var defaults: UserDefaults {
        guard let defaults = UserDefaults(suiteName: Constants.suiteName) else {
            LOG("Unable to create shared User Defaults", level: .error)
            return UserDefaults.standard
        }
        return defaults
    }
}
