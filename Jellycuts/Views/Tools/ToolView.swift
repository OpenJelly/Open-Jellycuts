//
//  ToolView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/28/23.
//

import SwiftUI

struct ToolView: View {
    @EnvironmentObject private var appearanceManager: AppearanceManager

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
                    BridgeList()
                } label: {
                    Label(.jellycutsBridge)
                }

            }
            .navigationTitle("Tools")
        }
        .rounded()
        .tint(appearanceManager.accentColor.color)
        .preferredColorScheme(appearanceManager.colorScheme == .system ? nil : (appearanceManager.colorScheme == .light ? .light : .dark))
        .dynamicTypeSize(appearanceManager.preferredDynamicTypeSize)
    }
}

struct ToolView_Previews: PreviewProvider {
    static var previews: some View {
        ToolView()
    }
}
