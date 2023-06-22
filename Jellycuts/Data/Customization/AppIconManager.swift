//
//  AppIconManager.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

struct AppIconManager {
    enum StandardIcons: String, CaseIterable, Identifiable {
        case primary = "AppIcon"
        case jellyfishSix = "AppIcon-Jellyfish-Six"
        case tribute = "AppIcon-Tribute"
        case deepSea = "AppIcon-Deep-Sea"
        case retroid = "AppIcon-Retroid"
        case inverted = "AppIcon-Inverted"
        case milkshake = "AppIcon-Milkshake"
        case tropical = "AppIcon-Tropical"
        case lime = "AppIcon-Lime"
        case cottonCandy = "AppIcon-Cotton-Candy"
        case pinky = "AppIcon-Pinky"
        case sunset = "AppIcon-Sunset"
        case seaFoam = "AppIcon-Sea-Foam"
        case sangria = "AppIcon-Sangria"
        case hope = "AppIcon-Hope"
        case rainbowInTheDark = "AppIcon-Rainbow-In-The-Dark"
        case outline = "Outline"
        case lightsOut = "AppIcon-Lights-Out"
        case macintosh = "AppIcon-Macintosh"
        case neon = "AppIcon-Neon"
        
        var id: String { self.rawValue }
        
        var name: String {
            switch self {
            case .primary:
                return "Default"
            case .jellyfishSix:
                return "Jellyfish Six"
            case .tribute:
                return "Shortcuts Tribute"
            case .deepSea:
                return "Deep Sea"
            case .retroid:
                return "Retroid"
            case .inverted:
                return "Inverted"
            case .milkshake:
                return "Milkshake"
            case .tropical:
                return "Tropical"
            case .lime:
                return "Lime"
            case .cottonCandy:
                return "Cotton Candy"
            case .pinky:
                return "Pinky"
            case .sunset:
                return "Sunset"
            case .seaFoam:
                return "Sea Foam"
            case .sangria:
                return "Sangria"
            case .hope:
                return "Hope"
            case .rainbowInTheDark:
                return "Rainbow In The Dark"
            case .outline:
                return "Outline"
            case .lightsOut:
                return "Lights Out"
            case .macintosh:
                return "Macintosh"
            case .neon:
                return "Neon"
            }
        }
    }
    
    enum ProIcons: String, CaseIterable, Identifiable {
        case pro = "AppIcon-Pro"
        case proInverted = "AppIcon-Pro-Inverted"

        var id: String { self.rawValue }
        
        var name: String {
            switch self {
            case .pro:
                return "Pro Mode"
            case .proInverted:
                return "Pro Mode Inverted"
            }
        }
    }
       
    enum PrideIcons: String, CaseIterable, Identifiable {
        case pride = "AppIcon-Pride"
        case progression = "AppIcon-Progressive-Pride"
        case trans = "AppIcon-Trans-Pride"
        case lesbian = "AppIcon-Lesbian-Pride"
        case bisexual = "AppIcon-Bisexual-Pride"
        case intersex = "AppIcon-Intersex-Pride"
        case nonbinary = "AppIcon-Nonbinary-Pride"
        
        var id: String { self.rawValue }
        
        var name: String {
            switch self {
            case .pride:
                return "Pride"
            case .progression:
                return "Progressive"
            case .trans:
                return "Transgender Pride"
            case .lesbian:
                return "Lesbian Pride"
            case .bisexual:
                return "Bisexual Pride"
            case .intersex:
                return "Intersex Pride"
            case .nonbinary:
                return "Nonbinary Pride"
            }
        }
    }
    
    enum HiddenIcons: String, CaseIterable, Identifiable {
        case beta = "AppIcon-Beta"
        case dev = "AppIcon-Developer"
        case launched = "AppIcon-Launched"

        var id: String { self.rawValue }
        
        var name: String {
            switch self {
            case .beta:
                return "Beta Tester"
            case .dev:
                return "Jellycuts Developer"
            case .launched:
                return "Launched"
            }
        }
    }

    static func getAppIconName(for bundleName: String) -> String {
        if let icon = StandardIcons(rawValue: bundleName) {
            return icon.name
        }
        if let icon = ProIcons(rawValue: bundleName) {
            return icon.name
        }
        if let icon = PrideIcons(rawValue: bundleName) {
            return icon.name
        }
        if let icon = HiddenIcons(rawValue: bundleName) {
            return icon.name
        }
        
        return "Default"
    }
}
