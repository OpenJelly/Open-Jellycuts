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
    @State var searchText: String = ""
    
    var body: some View {
        List {
            Section("Information") {
                Text(library.description)
                CodeBlock(text: library.importCode)
            }
            Section("Actions") {
                ForEach(filterActions(actions: library.actions, searchText: searchText)) { action in
                    NavigationLink {
                        DocumentationActionView(action: action)
                    } label: {
                        actionCell(action: action)
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "Search \(library.name) Actions")
        .navigationTitle(library.name)
    }
    
    private func filterActions(actions: [DocumentationActionEntry], searchText: String) -> [DocumentationActionEntry] {
        guard !searchText.isEmpty else { return actions }
        return actions.filter { action in
            action.name.lowercased().contains(searchText.lowercased()) ||
            action.correctTypedFunction.lowercased().contains(searchText.lowercased()) ||
            action.syntax.lowercased().contains(searchText.lowercased()) ||
            action.description.lowercased().contains(searchText.lowercased())
        }
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
