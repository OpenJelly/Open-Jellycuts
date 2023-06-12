//
//  Constants.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import Foundation

enum Constants {
    static let keychainAccessGroup = "lineman.Jellycuts"
    static let suiteName = "group.jellycuts"
}

enum DefaultsKeys {
    static let dictionaryBuilderKey = "dictionaryBuilderDictionaries"
    static let lastSignedShortcutDataKey = "Last-Data"
    static let lastSignedShortcutNameKey = "Last-Name"
}

enum Links {
    static let signingURL: URL = URL(string: "https://actuallyhome.herokuapp.com/API/routing/request")!
    static let taylorLinemanMastodon: URL = URL(string: "https://mastodon.social/@TaylorLineman")!
    static let jellycutsGithubPage: URL = URL(string: "https://github.com/ActuallyTaylor/Open-Jellycuts")!
    static let jellycutsWebpage: URL = URL(string: "https://jellycuts.com")!
    static let jellycutsEmail: URL = URL(string: "mailto:jellycuts@gmail.com")!
    static let discordLink: URL = URL(string: "https://discord.com/invite/jVRPXza")!
    static let bugReport: URL = URL(string: "https://github.com/ActuallyTaylor/Open-Jellycuts/issues")!
    
    static let betterSafariView = URL(string: "https://github.com/stleamist/BetterSafariView")!
    static let hydrogenReporter = URL(string: "https://github.com/ActuallyTaylor/HydrogenReporter")!
    static let keychainSwift = URL(string: "https://github.com/evgenyneu/keychain-swift")!
    static let treeSitter = URL(string: "https://github.com/ActuallyTaylor/tree-sitter-spm")!
    static let runestone = URL(string: "https://github.com/ActuallyTaylor/Runestone")!
    static let treeSitterJelly = URL(string: "https://github.com/ActuallyTaylor/tree-sitter-jelly")!
    static let openJellycore = URL(string: "https://github.com/ActuallyTaylor/Open-Jellycore")!

}

enum PreferenceValues: String, CaseIterable {
    case accentColor
    case colorScheme
    case typeSize
    case inAppBrowser
    case haptics
    case projectSort
    case editorLightTheme
    case editorDarkTheme
}

enum KeychainValues: String, CaseIterable {
    case hasSubscribed
}

extension NSNotification.Name {
    static let purchaseNotification = NSNotification.Name("purchaseNotification")
    static let purchaseErrorNotification = NSNotification.Name("purchaseErrorNotification")
    static let finishedPurchasing = NSNotification.Name("finishedPurchasing")
}
