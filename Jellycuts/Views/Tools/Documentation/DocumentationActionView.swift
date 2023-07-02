//
//  DocumentationActionView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI
import Open_Jellycore
import UniformTypeIdentifiers

struct DocumentationActionView: View {
    var action: DocumentationActionEntry
    var currentVersion: ShortcutsHostVersion {
        #if os(macOS)
        return .macOS12//"1125.1"
        #endif
        return .iOS16
    }
    
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 20) {
                VStack(alignment: .leading) {
                    Text("Availability")
                        .font(.title2)
                        .fontWeight(.semibold)
                    availabilityCell()
                }
                
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(action.description)
                }
                
                VStack(alignment: .leading) {
                    Text("Syntax")
                        .font(.title2)
                        .fontWeight(.semibold)
                    CodeBlock(text: action.syntax)
                }

                VStack(alignment: .leading) {
                    Text("Example")
                        .font(.title2)
                        .fontWeight(.semibold)
                    CodeBlock(text: action.example)
                }

            }
            .padding(.horizontal)
        }
        .listStyle(.plain)
        .navigationTitle(action.name)
    }
    
    @ViewBuilder
    func availabilityCell() -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(alignment: .firstTextBaseline) {
                ForEach(ShortcutsHostVersion.allCases, id: \.self) { version in
                    VStack {
                        Text(version.name)
                            .padding(5)
                            .font(.system(size: 16, weight: .regular, design: .rounded))
                            .foregroundColor(Color.white)
                    }
                    .padding(.horizontal, 5)
                    .background(action.iOSVersion.version < currentVersion.version ? Color.blue : Color.red)
                    .cornerRadius(7)
                }
            }
        }
    }
    
}

struct DocumentationActionView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            if let library = DocumentationGenerator.generateDocumentation().first,
               let action = library.actions.first {
                DocumentationActionView(action: action)
            } else {
                Text("No Library")
            }
        }
    }
}
