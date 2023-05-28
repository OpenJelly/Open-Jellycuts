//
//  DocumentationHomeView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import Open_Jellycore

struct DocumentationHomeView: View {
    var body: some View {
        List {
            ForEach(DocumentationGenerator.generateDocumentation()) { library in
                NavigationLink {
                    DocumentationLibraryView(library: library)
                } label: {
                    libraryCell(library: library)
                }
            }
        }
        .navigationTitle("Documentation")
    }
    
    @ViewBuilder
    func libraryCell(library: DocumentationLibraryEntry) -> some View {
        VStack(alignment: .leading) {
            Text(library.name)
            Text("\(library.actions.count) provided actions")
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }

}

struct DocumentationHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DocumentationHomeView()
    }
}
