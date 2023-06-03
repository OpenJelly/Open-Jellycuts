//
//  ContentView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter
import Runestone

struct DocumentView: View, ErrorHandler {
    @Environment(\.openURL) private var openURL

    @StateObject var editorConfig = RunestoneEditorConfig()
    @StateObject var viewModel = DocumentViewModel()
    
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = true
    
    var project: Project
    
    @State var presentSheetView: Bool = false
    @State var presentDocumentation: Bool = false
    
    @State var isExporting: Bool = false
    @State var exportedShortcutURL: URL? = nil
    
    init(project: Project) {
        self.project = project
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            RunestoneEditor(text: $viewModel.text, config: editorConfig)
            VStack(spacing: 5) {
                ConsoleView(warningCount: $viewModel.warningCount, errorCount: $viewModel.errorCount, consoleText: $viewModel.consoleText)
                ToolBarView(recommendations: $viewModel.textRecommendation, canUndo: $editorConfig.canUndo, canRedo: $editorConfig.canRedo, insertText: { selectedText in
                    editorConfig.insertText(text: selectedText)
                }, undo: {
                    editorConfig.undo()
                }, redo: {
                    editorConfig.redo()
                }, openDocumentation: {
                    presentDocumentation.toggle()
                }, build: {
                    Task {
                        do {
                            try await viewModel.build(project)
                        } catch {
                            handle(error: error)
                        }
                    }
                })
            }
        }
        .navigationTitle("Editing")
        .withToolsSheet(isPresented: $presentSheetView)
        .sheet(isPresented: $presentDocumentation) {
            NavigationView {
                DocumentationHomeView()
            }
            .presentationDetents([.large, .medium])
        }
        .quicklook($exportedShortcutURL)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    presentSheetView.toggle()
                } label: {
                    Label(.tools)
                        .labelStyle(.iconOnly)
                }
                Button {
                    Task {
                        isExporting = true
                        do {
                            exportedShortcutURL = try await viewModel.compile(project)
                        } catch {
                            print("Got Error \(error)")
                            handle(error: error)
                        }
                        isExporting = false
                    }
                } label: {
                    if isExporting {
                        ProgressView()
                    } else {
                        Label("Compile", image: "spaceship.fill")
                            .labelStyle(.iconOnly)
                    }
                }
                .disabled(isExporting)
            }
        }
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
        .onAppear {
            loadText()
        }
        .onChange(of: viewModel.text) { newValue in
            do {
                print("Saving Document")
                try DocumentHandling.writeContents(for: project, text: viewModel.text)
            } catch {
                handle(error: error)
            }
        }
    }
    
    private func loadText() {
        if !viewModel.hasInitializedText {
            viewModel.hasInitializedText = true
            do {
                let url = try DocumentHandling.getProjectURL(for: project)
                let contents = try String(contentsOf: url)
                viewModel.text = contents
            } catch {
                LOG(error, level: .error)
                handle(error: error)
            }
        }
    }
}
