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

    init() { }
    
    func build(_ project: Project) async throws {
        try await compile(project)
    }
        
    @discardableResult
    func compile(_ project: Project) async throws -> URL {
        let parser = Parser(contents: text)
        try parser.parse()
        
        let transpiler = Transpiler(parser: parser)
        let shortcut = try transpiler.compile()

        if !ErrorReporter.shared.errors.isEmpty {
            print("Found \(ErrorReporter.shared.errors.count) errors")
            for error in ErrorReporter.shared.errors {
                print(error.errorDescription ?? "No Description", error.recoverySuggestion ?? "No Suggestion")
            }
        } else {
            print("Successfully Compiled Shortcut")
        }

        let projectURL = try DocumentHandling.getProjectURL(for: project)
        let exportURL = try await ShortcutsSigner.sign(fileURL: projectURL, shortcut: shortcut)
        
        return exportURL

    }
}
