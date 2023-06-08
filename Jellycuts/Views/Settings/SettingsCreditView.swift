//
//  SettingsCreditView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsCreditView: View {
    var body: some View {
        List {
            Section("People") {
                peopleEntry(title: "The Amazing Shortcuts Team @ Apple", subtitle: "For helping out along the way")
                peopleEntry(title: "Beta Testers", subtitle: "For helping iron out the app, and sticking with it")
                peopleEntry(title: "Antonio Bueno", subtitle: "Helping create shortcuts glyphs")
                peopleEntry(title: "pfg creator of SCPL", subtitle: "For telling me about replacement characters")
            }
            Section("Open Source Content") {
                Link(destination: Links.betterSafariView) {
                    Label("BetterSafariView", systemImage: "link")
                }
                Link(destination: Links.keychainSwift) {
                    Label("Keychain Swift", systemImage: "link")
                }
                Link(destination: Links.treeSitter) {
                    Label("TreeSitter", systemImage: "link")
                }
                Link(destination: Links.runestone) {
                    Label("Runestone", systemImage: "link")
                }
                Link(destination: Links.treeSitterJelly) {
                    Label("tree-sitter-jelly", systemImage: "link")
                }
                Link(destination: Links.openJellycore) {
                    Label("Open Jellycore", systemImage: "link")
                }
                Link(destination: Links.hydrogenReporter) {
                    Label("Hydrogen Reporter", systemImage: "link")
                }
            }
        }
        .navigationTitle("Credits")
    }
    
    @ViewBuilder
    private func peopleEntry(title: String, subtitle: String) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.headline)
            Text(subtitle)
                .font(.caption2)
                .foregroundColor(.secondary)
        }
    }
}

struct SettingsCreditView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsCreditView()
    }
}
