//
//  DocumentationHomeView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import Open_Jellycore

struct DocumentationHomeView: View {
    var documentation: [DocumentationLibraryEntry] = DocumentationGenerator.generateDocumentation()
    @State var searchText: String = ""
    
    var body: some View {
        List {
            ForEach(filterDocumentation(entries: documentation, searchText: searchText)) { library in
                NavigationLink {
                    DocumentationLibraryView(library: library)
                } label: {
                    libraryCell(library: library)
                }
            }
        }
        .searchable(text: $searchText, placement: .sidebar, prompt: "Search Documentation")
        .navigationTitle("Documentation")
    }
    
    @ViewBuilder
    private func libraryCell(library: DocumentationLibraryEntry) -> some View {
        VStack(alignment: .leading) {
            Text(library.name)
            Text("\(library.actions.count) provided actions")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }

    private func filterDocumentation(entries: [DocumentationLibraryEntry], searchText: String) -> [DocumentationLibraryEntry] {
        guard !searchText.isEmpty else { return entries }
        return entries.filter { entry in
            entry.name.lowercased().contains(searchText.lowercased()) ||
            entry.importName.lowercased().contains(searchText.lowercased()) ||
            entry.description.lowercased().contains(searchText.lowercased())
        }
    }
}

struct DocumentationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationHomeView()
    }
}
