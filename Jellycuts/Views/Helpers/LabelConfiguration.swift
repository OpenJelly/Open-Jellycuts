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
    case undo
    case redo
    case build

    // MARK: Tools Page
    case documentation
    case thirdPartyObjectStorage
    case dictionaryBuilder
    case iconCreator
    case jellycutsBridge
    
    // MARK: Common
    case copy
    case create
    
    // MARK: Settings
    case settings
    case appearance
    case behavior
    case reportABug
    case contact
    case privacy
    case credits
    case about
    
    // Appearance
    case environment(isDark: Bool)
    
    // Behavior
    case haptics
    case browser
    case projectSort
    case jellycutsBrowser
    case safariBrowser

        
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
        case .create:
            return "plus"
        case .undo:
            return "arrow.uturn.backward.circle"
        case .redo:
            return "arrow.uturn.forward.circle"
        case .build:
            return "hammer"
        case .settings:
            return "gearshape"
        case .appearance:
            return "paintbrush"
        case .behavior:
            return "slider.horizontal.3"
        case .reportABug:
            return "ant"
        case .contact:
            return "paperplane"
        case .privacy:
            return "hand.raised"
        case .credits:
            return "sparkles"
        case .about:
            return "info.circle"
        case .environment(let isDark):
            return isDark ? "moon.stars.fill" : "sun.max.fill"
        case .haptics:
            return "waveform"
        case .browser:
            return "network"
        case .projectSort:
            return "line.3.horizontal.decrease.circle"
        case .jellycutsBrowser:
            return "app.gift"
        case .safariBrowser:
            return "safari"
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
        case .create:
            return "Create"
        case .undo:
            return "Undo Change"
        case .redo:
            return "Redo Change"
        case .build:
            return "Build"
        case .settings:
            return "Settings"
        case .appearance:
            return "Appearance"
        case .behavior:
            return "Behavior"
        case .reportABug:
            return "Report a bug"
        case .contact:
            return "Contact"
        case .privacy:
            return "Privacy"
        case .credits:
            return "Credits"
        case .about:
            return "About"
        case .environment(_):
            return "Environment"
        case .haptics:
            return "Haptics"
        case .browser:
            return "Browser"
        case .projectSort:
            return "Project Sort"
        case .jellycutsBrowser:
            return "Jellycuts"
        case .safariBrowser:
            return "Safari"
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
