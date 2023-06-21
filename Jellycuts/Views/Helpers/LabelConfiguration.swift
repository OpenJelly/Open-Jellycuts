//
//  LabelConfiguration.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import SFSymbols

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
    case proMode
    
    // Appearance
    case environment(isDark: Bool)
    
    // Behavior
    case haptics
    case browser
    case projectSort
    case jellycutsBrowser
    case safariBrowser
    
    // MARK: Bridge Page
    case pullFromServer

        
    var icon: SFSymbol {
        switch self {
        case .compile:
            return .custom("spaceship.fill")
        case .tools:
            return .wrench_and_screwdriver_fill
        case .documentation:
            return .doc_richtext
        case .thirdPartyObjectStorage:
            return .server_rack
        case .dictionaryBuilder:
            return .curlybraces_square
        case .iconCreator:
            return .app_gift
        case .jellycutsBridge:
            return .desktopcomputer
        case .copy:
            return .doc_on_doc
        case .create:
            return .plus
        case .undo:
            return .arrow_uturn_backward_circle
        case .redo:
            return .arrow_uturn_forward_circle
        case .build:
            return .hammer
        case .settings:
            return .gearshape
        case .appearance:
            return .paintbrush
        case .behavior:
            return .slider_horizontal_3
        case .reportABug:
            return .ant
        case .contact:
            return .paperplane
        case .privacy:
            return .hand_raised
        case .credits:
            return .sparkles
        case .about:
            return .info_circle
        case .environment(let isDark):
            return isDark ? .moon_stars_fill : .sun_max_fill
        case .haptics:
            return .waveform
        case .browser:
            return .network
        case .projectSort:
            return .line_3_horizontal_decrease_circle
        case .jellycutsBrowser:
            return .app_gift
        case .safariBrowser:
            return .safari
        case .pullFromServer:
            return .server_rack
        case .proMode:
            return .key_fill
        }
    }
    
    var title: String {
        switch self {
        case .compile:
            return "Compile"
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
        case .pullFromServer:
            return "Pull Code From Server"
        case .proMode:
            return "Jellycuts Pro"
        }
    }
}

extension Label<Text, Image> {
    init(_ config: LabelConfiguration) {
        self.init {
            Text(config.title)
        } icon: {
            Image(config.icon)
        }
    }
}
