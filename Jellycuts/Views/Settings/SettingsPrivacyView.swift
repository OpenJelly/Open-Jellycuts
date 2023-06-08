//
//  SettingsPrivacyView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsPrivacyView: View {
    var body: some View {
        List {
//            Section("Your Data Inside of Jellycuts") {
//                Text("When you use Jellycuts, anonymous usage data is collected. This data is collected using [Telemetry Deck](https://telemetrydeck.com/pages/privacy-policy.html), an anonymous lightweight analytics tool. This data is collected purely for data on what features need to be prioritized in development, along with what features (if any) are causing crashes. If you do not wish for anonymous data to be collected, you can turn off data collection in the privacy settings of Jellycuts.")
//            }
            Section("Your Data Inside of Jellycuts") {
                Text("On iOS and iPadOS 15 and above, Jellycuts will connect to a server for signing the current Jellycut file. This is needed because of changes in iOS and iPadOS 15 which require shortcuts to be verified . Each file you upload is not saved, and NEVER seen by a human, these files are uploaded and then sent back to you signed. When you connect to this server, your IP may be logged temporally by Heroku but is NOT used for tracking.")
            }

        }
        .navigationTitle("Privacy")
    }
}

struct SettingsPrivacyView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPrivacyView()
    }
}
