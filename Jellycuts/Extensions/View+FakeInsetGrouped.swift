//
//  View+FakeInsetGrouped.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/8/23.
//

import SwiftUI

extension View {
    func fakeInsetGrouped() -> some View {
        return self
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(uiColor: .secondarySystemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal, 20)
    }
}
