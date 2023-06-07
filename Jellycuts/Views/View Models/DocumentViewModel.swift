//
//  DocumentViewModel.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import SwiftUI
import Open_Jellycore

class DocumentViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var hasInitializedText: Bool = false
    @Published var textRecommendation: [String] = []

    @Published var warningCount: Int = 0
    @Published var errorCount: Int = 0
    @Published var consoleText: NSAttributedString = NSAttributedString()

    init() { }
    
    func build(_ project: Project) async throws {
        ErrorReporter.shared.reset()
        try await compile(project)
        await updateConsole()
    }
        
    @discardableResult
    func compile(_ project: Project) async throws -> URL? {
        ErrorReporter.shared.reset()
        let parser = Parser(contents: text)
        try parser.parse()
        
        let compiler = Compiler(parser: parser)
        let shortcut = try compiler.compile(named: project.name ?? "Unnamed Jellycut")

        await updateConsole()
        
        if !ErrorReporter.shared.errors.isEmpty {
            print("Found \(ErrorReporter.shared.errors.count) errors")
            for error in ErrorReporter.shared.errors {
                print(error.errorDescription ?? "No Description", error.recoverySuggestion ?? "No Suggestion")
            }
            
            return nil
        } else {
            print("Successfully Compiled Shortcut")
            
            let projectURL = try DocumentHandling.getProjectURL(for: project)
            let exportURL = try await ShortcutsSigner.sign(fileURL: projectURL, shortcut: shortcut)
            
            return exportURL
        }
    }
    
    @MainActor
    func updateConsole() {
        errorCount = ErrorReporter.shared.numberOfErrors
        warningCount = ErrorReporter.shared.numberOfWarnings
        consoleText = ErrorReporter.shared.getErrorText()
    }
}
