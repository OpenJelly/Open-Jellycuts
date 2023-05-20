//
//  PasteView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/18/23.
//

import SwiftUI

struct PasteView: View {
    @Environment(\.dismiss) private var dismiss

    var imageNames: [String] = ["mac", "mac 1", "mac 2"]

    var body: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .bold()
                }
                .foregroundColor(.secondary)
                Spacer()
            }
            .padding()
            TabView {
                ForEach(imageNames, id: \.hash) { name in
                    Image(name)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(height: 300)
            Button("Go To Settings") {
                if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                }
            }
//            .buttonStyle(<#T##style: PrimitiveButtonStyle##PrimitiveButtonStyle#>)
        }
    }
}

struct PasteView_Previews: PreviewProvider {
    static var previews: some View {
        PasteView()
    }
}
