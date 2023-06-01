//
//  QuickLook.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import SwiftUI
import QuickLook

extension View {
    @ViewBuilder
    func quicklook(_ url: Binding<URL?>) -> some View {
        GeometryReader { reader in
            if (UIDevice.isMac) {
                self
            } else {
            #if targetEnvironment(macCatalyst)
                self
            #else
                self.quickLookPreview(url)
            #endif
            }
        }
    }
}
