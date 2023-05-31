//
//  RunestoneEditor.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/17/23.
//

import UIKit
import SwiftUI
import Runestone
import TreeSitterJellyRunestone

struct RunestoneEditor: UIViewRepresentable {
    @Binding var text: String
    var textView: TextView = TextView()
    
    init(text: Binding<String>) {
        self._text = text
    }
    
    func makeUIView(context: Context) -> TextView {
        setState(text: text)
        setCustomization()
        textView.editorDelegate = context.coordinator
        return textView
    }
    
    func updateUIView(_ uiView: TextView, context: Context) {
        if text != textView.text {
            setState(text: text)
        }
    }
    
    private func setState(text: String) {
        let state = TextViewState(text: text, language: .jelly)
        textView.setState(state)
    }
    
    private func setCustomization() {
        textView.backgroundColor = .systemBackground
        textView.textContainerInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        textView.showLineNumbers = true
        textView.lineHeightMultiplier = 1.2
        textView.kern = 0.3
        textView.showSpaces = true
        textView.showNonBreakingSpaces = true
        textView.showTabs = true
        textView.showLineBreaks = true
        textView.showSoftLineBreaks = true
        textView.isLineWrappingEnabled = false
        textView.showPageGuide = true
        textView.pageGuideColumn = 80
        textView.autocorrectionType = .no
        textView.autocapitalizationType = .none
        textView.smartQuotesType = .no
        textView.smartDashesType = .no
        textView.isEditable = true
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: TextViewDelegate {
        let parent: RunestoneEditor

        init(_ parent: RunestoneEditor) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: TextView) {
            DispatchQueue.main {
                self.parent.text = textView.text
            }
        }
    }
}
