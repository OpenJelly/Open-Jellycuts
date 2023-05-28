//
//  ContentView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter
import Runestone

struct ContentView: View {
    var project: Project
    @State var text: String = ""
    
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
            RunestoneEditor()
        }
        .navigationTitle("Editing")
    }
}


