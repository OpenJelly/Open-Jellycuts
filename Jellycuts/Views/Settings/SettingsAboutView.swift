//
//  SettingsAboutView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsAboutView: View {
    var body: some View {
        ScrollView {
            VStack {
                Image("\(UIApplication.shared.alternateIconName ?? "AppIcon")-I")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .cornerRadius(20)
                    .padding([.leading, .trailing], 75)
                    .padding()
                    .frame(maxWidth: 400, maxHeight: 400)
                    .shadow(radius: 7)
                Text("Jellycuts")
                    .font(.title)
                    .bold()
                Text("Developed with ❤️ by Taylor Lineman")
                    .font(.headline)
                    .foregroundColor(.secondary)
                Text("Thank you for installing and using Jellycuts!\n\nThis version of Jellycuts was developed with the intent for it to be improved upon and open for the entire community. That is why the source code for every part of the app is up on GitHub! I really hope you enjoy using Jellycuts to make your Shortcuts development process smoother!\n\nHave a splendid day! ~ Taylor Lineman")
                    .font(.footnote)
                    .foregroundColor(.secondary)
                    .padding()
            }
        }
        .navigationTitle("About")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsAboutView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAboutView()
    }
}
