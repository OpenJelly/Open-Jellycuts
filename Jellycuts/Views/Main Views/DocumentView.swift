//
//  ContentView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter
import Runestone

struct DocumentView: View {
    var project: Project
    @State var text: String = ""
    
    @State var presentSheetView: Bool = false
    
    init(project: Project) {
        self.project = project
        
        if let url = URL(string: self.project.url!) {
            do {
                self.text = try String(contentsOf: url)
            } catch {
                LOG(error, level: .error)
            }
        } else {
            LOG("Unable to get URL")
        }
    }

    var body: some View {
        VStack {
            RunestoneEditor(text: $text)
        }
        .withToolsSheet(isPresented: $presentSheetView)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Label(.compile)
                        .labelStyle(.iconOnly)
                }
                Button {
                    presentSheetView.toggle()
                } label: {
                    Label(.tools)
                        .labelStyle(.iconOnly)
                }
            }
        }
        .navigationTitle("Editing")
    }
}

//struct DocumentView_Previews: PreviewProvider {
//    static var previews: some View {
//        DocumentView(project: <#Project#>)
//    }
//}

