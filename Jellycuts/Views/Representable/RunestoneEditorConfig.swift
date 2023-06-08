//
//  RunestoneEditorConfig.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import SwiftUI
import RunestoneThemes

class RunestoneEditorConfig: ObservableObject {
    @Published var undoFlag: Int = 0
    @Published var redoFlag: Int = 0
    @Published var insertText: String? = nil
    
    @Published var canUndo: Bool = false
    @Published var canRedo: Bool = false
    
    @Published var theme: EditorTheme = .tomorrow
    
    init() { }
    
    func undo() {
        Dispatch.main {
            self.undoFlag += 1
        }
    }
    
    func consumeUndo() {
        Dispatch.main {
            self.undoFlag -= 1
        }
    }
    
    func redo() {
        Dispatch.main {
            self.redoFlag += 1
        }
    }
    
    func consumeRedo() {
        Dispatch.main {
            self.redoFlag -= 1
        }
    }

    func insertText(text: String) {
        self.insertText = text
    }
    
    func consumeInsert() -> String {
        guard let text = insertText else { return "" }
        Dispatch.main {
            self.insertText = nil
        }
        return text
    }
}
