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
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.openURL) private var openURL
    @EnvironmentObject private var appearanceManager: AppearanceManager

    @StateObject var editorConfig: RunestoneEditorConfig
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
        
        let config = RunestoneEditorConfig()
        config.lightTheme = AppearanceManager.shared.lightEditorTheme
        config.darkTheme = AppearanceManager.shared.darkEditorTheme
        self._editorConfig = StateObject(wrappedValue: config)
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
        .background(Color(uiColor: editorConfig.currentTheme.backgroundColor))
        .toolbarBackground(Color(uiColor: editorConfig.currentTheme.backgroundColor))
        .onAppear {
            editorConfig.lightTheme = appearanceManager.lightEditorTheme
            editorConfig.darkTheme = appearanceManager.darkEditorTheme
            project.lastOpened = .now
            try? viewContext.save()
            loadText()
        }
        .navigationBarTitleDisplayMode(.inline)
        .withToolsSheet(isPresented: $presentSheetView)
        .sheet(isPresented: $presentDocumentation) {
            NavigationView {
                DocumentationHomeView()
            }
            .presentationDetents([.large, .medium])
        }
        .quicklook($exportedShortcutURL)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text(project.name ?? "No Name")
                    .font(.headline)
                    .foregroundColor(Color(uiColor: editorConfig.currentTheme.foregroundColor))
            }
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
        .onChange(of: viewModel.text) { newValue in
            do {
                try DocumentHandling.writeContents(for: project, text: viewModel.text)
            } catch {
                handle(error: error)
            }
        }
        .onChange(of: appearanceManager.lightEditorTheme) { newValue in
            editorConfig.lightTheme = newValue
        }
        .onChange(of: appearanceManager.darkEditorTheme) { newValue in
            editorConfig.darkTheme = newValue
        }
        .environment(\.colorScheme, editorConfig.currentTheme.colorScheme)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentView(project: try! PersistenceController.preview.container.viewContext.fetch(Project.fetchRequest()).first!)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

