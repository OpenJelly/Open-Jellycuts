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
                    
                } label: {
                    Label(.thirdPartyObjectStorage)
                }
                NavigationLink {
                    
                } label: {
                    Label(.dictionaryBuilder)
                }
                NavigationLink {
                    
                } label: {
                    Label(.iconCreator)
                }
                NavigationLink {
                    
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
