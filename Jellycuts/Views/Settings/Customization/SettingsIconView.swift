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
    
    @State private var hiddenMessage: String = ""
    @State private var showHiddenAlert: Bool = false
    
    var body: some View {
        List {
            Section("Default Collection") {
                ForEach(AppIconManager.StandardIcons.allCases) { icon in
                    iconRow(rawValue: icon.rawValue, name: icon.name)
                }
            }
            Section("Pro Collection") {
                ForEach(AppIconManager.ProIcons.allCases) { icon in
                    iconRow(rawValue: icon.rawValue, name: icon.name, proIcon: true)
                }
            }
            Section("Pride Collection") {
                ForEach(AppIconManager.PrideIcons.allCases) { icon in
                    iconRow(rawValue: icon.rawValue, name: icon.name)
                }
            }
            Section("Secret Collection 🤫 (These are hidden and need to be discovered)") {
                ForEach(AppIconManager.HiddenIcons.allCases) { icon in
                    iconRow(rawValue: icon.rawValue, name: icon.name, hidden: true)
                }
            }

        }
        .navigationTitle("Icons")
        .withProSheet(isPresented: $presentingPremiumView)
        .alert("Not Discovered", isPresented: $showHiddenAlert) {
            Button("Ok", role: .cancel) { }
        } message: {
            Text(hiddenMessage)
        }

    }
    
    @ViewBuilder
    func iconRow(rawValue: String, name: String, proIcon: Bool = false, hidden: Bool = false) -> some View {
        HStack {
            Button {
                if proIcon {
                    if PurchaseHandler.isProMode {
                        setIcon(name: rawValue)
                    } else {
                        presentingPremiumView.toggle()
                    }
                } else if (hidden && !AppIconManager.hiddenIconUnlocked(rawValue: rawValue)) {
                    if let icon = AppIconManager.HiddenIcons(rawValue: rawValue) {
                        switch icon {
                        case .beta:
                            hiddenMessage = "You must be a Jellycuts beta tester to unlock this icon!"
                        case .dev:
                            hiddenMessage = "You must be a developer of Jellycuts to unlock this icon!"
                        case .launched:
                            hiddenMessage = "To unlock the Launched icon you must find a hidden combination of icon and color in the Jelly editor."
                        }
                        showHiddenAlert = true
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
            if proIcon && !PurchaseHandler.isProMode || (hidden && !AppIconManager.hiddenIconUnlocked(rawValue: rawValue)) {
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
