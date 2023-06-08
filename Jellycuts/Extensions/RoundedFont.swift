//
//  RoundedFont.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

extension View {
    func rounded() -> some View {
        if #available(iOS 16.1, *) {
            return self.fontDesign(.rounded)
        } else {
            return self
        }
    }
}
