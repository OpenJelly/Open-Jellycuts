//
//  ToolView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI

struct ToolView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink {
                    DocumentationHomeView()
                } label: {
                    Label(.documentation)
                }
                NavigationLink {
                    Text("Third Party Object Storage")
                } label: {
                    Label(.thirdPartyObjectStorage)
                }
                NavigationLink {
                    DictionaryBuilderView()
                } label: {
                    Label(.dictionaryBuilder)
                }
                NavigationLink {
                    IconCreator()
                } label: {
                    Label(.iconCreator)
                }
                NavigationLink {
                    Text("Jellycuts Bridge")
                } label: {
                    Label(.jellycutsBridge)
                }

            }
            .navigationTitle("Tools")
        }
    }
}

struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView()
    }
}
