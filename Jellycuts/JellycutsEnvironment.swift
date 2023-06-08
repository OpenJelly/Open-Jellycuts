//
//  JellycutsEnvironment.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

extension View {
    func withEnvironment() -> some View {
        environmentObject(AppearanceManager.shared)
    }
    
    func withCustomization() -> some View {
        tint(AppearanceManager.shared.accentColor.color)
            .rounded()
            .preferredColorScheme(AppearanceManager.shared.colorScheme == .system ? nil : (AppearanceManager.shared.colorScheme == .light ? .light : .dark))
            .dynamicTypeSize(AppearanceManager.shared.preferredDynamicTypeSize)
    }
}
