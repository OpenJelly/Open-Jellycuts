//
//  SheetDelegator.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI

extension View {
    func withToolsSheet(isPresented: Binding<Bool>) -> some View {
        return self
            .sheet(isPresented: isPresented) {
                ToolView()
                    .presentationDetents([.large, .medium])
            }
    }
}
