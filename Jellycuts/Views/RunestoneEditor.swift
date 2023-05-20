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
    
    var textView: TextView = TextView()
    
    func makeUIView(context: Context) -> TextView {
        let text = ""
        let state = TextViewState(text: text, language: .jelly)
        textView.setState(state)

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
        
        return textView
    }
    
    func updateUIView(_ uiView: TextView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(textView)
    }

    final class Coordinator: TextViewDelegate {
        private let view: TextView

        init(_ view: TextView) {
            self.view = view
        }
    }
}
