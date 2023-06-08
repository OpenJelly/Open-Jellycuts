//
//  Haptics.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import UIKit

class Haptics {
    
    static var supported: Bool {
        (UIDevice.current.value(forKey: "_feedbackSupportLevel") as? Int) == 2
    }
    
    static var enabled: Bool {
        PreferenceManager.getHapticsEnabled()
    }
    
    static func playSuccess() {
        if !(enabled && supported) { return }
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.success)
    }
    
    static func playError() {
        if !(enabled && supported) { return }
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(.error)
    }
    
    static func playLightImpact() {
        if !(enabled && supported) { return }
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func playMediumImpact() {
        if !(enabled && supported) { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func playHeavyImpact() {
        if !(enabled && supported) { return }
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.prepare()
        generator.impactOccurred()
    }
    
    static func playSelectionImpact() {
        if !(enabled && supported) { return }
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
}
