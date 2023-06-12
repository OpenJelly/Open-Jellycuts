//
//  SettingsIconView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI
import HydrogenReporter

struct SettingsIconView: View {
    @EnvironmentObject private var appearanceManager: AppearanceManager

    @State private var selectedIcon: String = UIApplication.shared.alternateIconName ?? "AppIcon"
    @State private var presentingPremiumView: Bool = false
    
    var body: some View {
        List {
            Section("Default Icons") {
                ForEach(AppIconManager.StandardIcons.allCases) { icon in
                    iconRow(rawValue: icon.rawValue, name: icon.name)
                }
            }
        }
        .navigationTitle("Icons")
        .withProSheet(isPresented: $presentingPremiumView)
    }
    
    @ViewBuilder
    func iconRow(rawValue: String, name: String, proIcon: Bool = false) -> some View {
        HStack {
            Button {
                if proIcon {
                    if PurchaseHandler.isProMode {
                        setIcon(name: rawValue)
                    } else {
                        presentingPremiumView.toggle()
                    }
                } else {
                    setIcon(name: rawValue)
                }
            } label: {
                HStack {
                    Image("\(rawValue)-I")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                        .frame(width: 55, height: 55)
                        .shadow(radius: 5)
                    Text(name)
                        .foregroundColor(.primary)
                    Spacer()
                }
            }
            if proIcon && !PurchaseHandler.isProMode {
                Spacer()
                Image(systemName: "lock.fill")
                    .foregroundColor(.accentColor)
            } else if selectedIcon == rawValue {
                Spacer()
                Image(systemName: "checkmark")
                    .foregroundColor(.accentColor)
            }
        }
    }
    
    func setIcon(name: String) {
        let iconName: String? = (name != "AppIcon") ? name : nil
        
        // Avoid setting the name if the app already uses that icon.
        guard UIApplication.shared.alternateIconName != iconName else { return }
        
        UIApplication.shared.setAlternateIconName(iconName) { (error) in
            if let error = error {
                LOG("Failed request to update the app’s icon: \(error)", level: .error)
            } else {
                selectedIcon = name
            }
        }
    }
}

struct SettingsIconView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsIconView()
    }
}
