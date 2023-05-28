//
//  LabelConfiguration.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI

enum LabelConfiguration {
    // MARK: Document View
    case compile
    case tools
    
    // MARK: Tools Page
    case documentation
    case thirdPartyObjectStorage
    case dictionaryBuilder
    case iconCreator
    case jellycutsBridge
    
    // MARK: Common
    case copy
    
    
    var icon: String {
        switch self {
        case .compile:
            return "spaceship"
        case .tools:
            return "wrench.and.screwdriver.fill"
        case .documentation:
            return "doc.richtext"
        case .thirdPartyObjectStorage:
            return "server.rack"
        case .dictionaryBuilder:
            return "curlybraces.square"
        case .iconCreator:
            return "app.gift"
        case .jellycutsBridge:
            return "desktopcomputer"
        case .copy:
            return "doc.on.doc"
        }
    }
    
    var title: String {
        switch self {
        case .compile:
            return "Compile Jellycut"
        case .tools:
            return "Tools"
        case .documentation:
            return "Documentation"
        case .thirdPartyObjectStorage:
            return "Third Party Object Storage"
        case .dictionaryBuilder:
            return "Dictionary Builder"
        case .iconCreator:
            return "Icon Creator"
        case .jellycutsBridge:
            return "Jellycuts Bridge"
        case .copy:
            return "Copy"
        }
    }
}

extension Label<Text, Image> {
    init(_ config: LabelConfiguration) {
        self.init {
            Text(config.title)
        } icon: {
            Image(systemName: config.icon)
        }
    }
}
