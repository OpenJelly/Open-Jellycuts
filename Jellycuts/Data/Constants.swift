//
//  Constants.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import Foundation

enum Constants {
    static let keychainAccessGroup = "lineman.Jellycuts"
    static let suiteName = "group.lineman.Jellycuts"
}

enum DefaultsKeys {
    static let dictionaryBuilderKey = "dictionaryBuilderDictionaries"
    static let lastSignedShortcutDataKey = "Last-Data"
    static let lastSignedShortcutNameKey = "Last-Name"
}

enum Links {
    static let signingURL: URL = URL(string: "https://actuallyhome.herokuapp.com/API/routing/request")!
}
