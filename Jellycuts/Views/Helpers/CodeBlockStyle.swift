//
//  CodeBlockStyle.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension Text {
    func codeBlockStyle() -> some View {
        return self
            .multilineTextAlignment(.leading)
            .fontDesign(.monospaced)
            .foregroundColor(.primary)
            .padding(10)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(uiColor: .secondarySystemBackground))
            .cornerRadius(10)

    }
}

struct CodeBlock: View {
    @State var text: String
    
    var body: some View {
        Menu {
            Button {
                UIPasteboard.general.setValue(text, forPasteboardType: UTType.plainText.identifier)
            } label: {
                Label(.copy)
            }
        } label: {
            Text(text)
                .codeBlockStyle()
        }
    }
}
