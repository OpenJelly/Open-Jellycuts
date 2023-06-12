//
//  SettingsView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI
import HydrogenReporter

struct SettingsView: View, ErrorHandler {
    @EnvironmentObject private var appearanceManager: AppearanceManager

    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = false
    
    @State internal var presentProMode: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section("Support") {
                    Button {
                        presentProMode.toggle()
                    } label: {
                        Label(.proMode)
                    }
                }
                Section("Learning") {
                    NavigationLink {
                        DocumentationHomeView()
                    } label: {
                        Label(.documentation)
                    }
                }
                Section("Customization") {
                    NavigationLink {
                        SettingsAppearanceView()
                    } label: {
                        Label(.appearance)
                    }
                    NavigationLink {
                        SettingsBehaviorView()
                    } label: {
                        Label(.behavior)
                    }
                }
                Section("About") {
                    NavigationLink {
                        SettingsContactView()
                    } label: {
                        Label(.contact)
                    }
                    NavigationLink {
                        SettingsCreditView()
                    } label: {
                        Label(.credits)
                    }
                    NavigationLink {
                        SettingsPrivacyView()
                    } label: {
                        Label(.privacy)
                    }
                    NavigationLink {
                        SettingsAboutView()
                    } label: {
                        Label(.about)
                    }
                }
                Section("Trouble Shooting") {
                    Link(destination: Links.bugReport) {
                        Label(.reportABug)
                    }
                    Button("Share Logs") {
                        do {
                            try shareLog()
                        } catch {
                            handle(error: error)
                        }
                    }
                }
            }
            .navigationTitle("Settings")
        }
        .rounded()
        .withProSheet(isPresented: $presentProMode)
        .tint(appearanceManager.accentColor.color)
        .preferredColorScheme(appearanceManager.colorScheme == .system ? nil : (appearanceManager.colorScheme == .light ? .light : .dark))
        .dynamicTypeSize(appearanceManager.preferredDynamicTypeSize)
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
    }
    
    @discardableResult
    func shareLog() throws -> Bool {
        guard let source = UIApplication.shared.currentUIWindow()?.rootViewController else {
            return false
        }
        
        let logFile = try Logger.shared.dumpToFile()
        
        let vc = UIActivityViewController(
            activityItems: [logFile],
            applicationActivities: nil
        )

        vc.popoverPresentationController?.sourceView = source.view
        source.present(vc, animated: true)
        return true
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .withEnvironment()
    }
}
