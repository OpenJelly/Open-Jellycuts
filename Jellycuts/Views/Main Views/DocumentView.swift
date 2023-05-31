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
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = true
    
    var project: Project
    @State var text: String

    @State var presentSheetView: Bool = false
    
    init(project: Project) {
        self.project = project
        
        do {
            let url = try DocumentHandling.getProjectURL(for: project)
            let contents = try String(contentsOf: url)
            self.text = contents
        } catch {
            self.text = "Error Loading Text"
            handle(error: error)
        }
    }

    var body: some View {
        VStack {
            RunestoneEditor(text: $text)
        }
        .navigationTitle("Editing")
        .withToolsSheet(isPresented: $presentSheetView)
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    presentSheetView.toggle()
                } label: {
                    Label(.tools)
                        .labelStyle(.iconOnly)
                }
                Button {
                    
                } label: {
                    Label("Compile", image: "spaceship.fill")
                        .labelStyle(.iconOnly)
                }
            }
        }
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
        .onChange(of: text) { newValue in
            
        }
    }
    
    private func loadText() {
        do {
            let url = try DocumentHandling.getProjectURL(for: project)
            let contents = try String(contentsOf: url)
            text = contents
            print(url, contents, text)
        } catch {
            LOG(error, level: .error)
            handle(error: error)
        }
    }
}
