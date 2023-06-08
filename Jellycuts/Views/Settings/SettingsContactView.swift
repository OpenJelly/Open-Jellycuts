//
//  SettingsContactView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsContactView: View {
    var body: some View {
        List {
            Link(destination: Links.taylorLinemanMastodon) {
                Label("Taylor Lineman Mastodon", systemImage: "link")
            }
            Link(destination: Links.jellycutsGithubPage) {
                Label("Jellycuts Github Page", systemImage: "link")
            }
            Link(destination: Links.jellycutsEmail) {
                Label("Jellycuts Email", systemImage: "mail")
            }
            Link(destination: Links.discordLink) {
                Label("Jellycuts Discord", systemImage: "link")
            }
        }
        .navigationTitle("Contact")
    }
}

struct SettingsContactView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsContactView()
    }
}
