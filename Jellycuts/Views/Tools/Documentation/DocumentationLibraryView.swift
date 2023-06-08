//
//  DocumentationLibraryView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import Open_Jellycore

struct DocumentationLibraryView: View {
    var library: DocumentationLibraryEntry
    
    var body: some View {
        List {
            Section("Information") {
                Text(library.description)
                CodeBlock(text: library.importCode)
            }
            Section("Actions") {
                ForEach(library.actions) { action in
                    NavigationLink {
                        DocumentationActionView(action: action)
                    } label: {
                        actionCell(action: action)
                    }
                }
            }
        }
        .navigationTitle(library.name)
    }
    
    @ViewBuilder
    func actionCell(action: DocumentationActionEntry) -> some View {
        VStack(alignment: .leading) {
            Text(action.name)
            Text(action.iOSVersion.name)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }

}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let library = DocumentationGenerator.generateDocumentation().first {
                DocumentationLibraryView(library: library)
            } else {
                Text("No Library")
            }
        }
    }
}
