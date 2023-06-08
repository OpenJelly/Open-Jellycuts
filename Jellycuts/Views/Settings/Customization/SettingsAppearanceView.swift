//
//  SettingsAppearanceView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsAppearanceView: View, ErrorHandler {
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = false

    @State private var customAccentColor: Color = AppearanceManager.shared.accentColor.color

    var body: some View {
        Form {
            Section {
                NavigationLink {
                    SettingsIconView()
                } label: {
                    HStack {
                        Image("\(UIApplication.shared.alternateIconName ?? "AppIcon")-I")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .cornerRadius(16.5)

                        VStack(alignment: .leading) {
                            Text("App Icon")
                                .font(.headline)
                            Text(AppIconManager.getAppIconName(for: UIApplication.shared.alternateIconName ?? "Default"))
                                .font(.caption)
                        }
                        .padding(.leading)
                    }
                }
            }
            Section("Theme") {
                accentColorView()
                environmentSelector()
            }
            Section("Text Size") {
                dynamicTextSize()
            }

        }
        .navigationTitle("Appearance")
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
    }
    
    @ViewBuilder
    func accentColorView() -> some View {
        VStack(alignment: .leading) {
            Text("Accent Color: ")
                .font(.headline)
            ScrollView([.horizontal], showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(AccentColor.allCases) { accent in
                        Button {
                            setAccentColor(color: accent)
                        } label: {
                            Image(systemName: "circle.fill")
                                .foregroundColor(accent.color)
                                .overlay {
                                    if appearanceManager.accentColor == accent {
                                        Circle()
                                            .foregroundColor(.white)
                                            .frame(width: 7, height: 7)
                                    }
                                }
                        }
                    }
                    ColorPicker(selection: $customAccentColor, label: { })
                }
            }
        }
        .onChange(of: customAccentColor) { newValue in
            setAccentColor(color: .custom(color: newValue))
        }
    }
    
    @ViewBuilder
    func environmentSelector() -> some View {
        HStack {
            Picker(selection: $appearanceManager.colorScheme) {
                ForEach(AppearanceManager.ColorEnvironment.allCases) { scheme in
                    Text(scheme.rawValue.capitalized)
                        .tag(scheme)
                }
            } label: {
                Label(.environment(isDark: appearanceManager.colorScheme == .dark))
            }
            .onChange(of: appearanceManager.colorScheme) { newValue in
                withAnimation {
                    appearanceManager.setAppEnvironment(scheme: newValue)
                }
            }
        }
    }

    @ViewBuilder
    func dynamicTextSize() -> some View {
        Picker("Text Size", selection: $appearanceManager.preferredDynamicTypeSize) {
            ForEach(DynamicTypeSize.allCases) { size in
                Text("\(size.description)")
                    .tag(size)
            }
        }
        .onChange(of: appearanceManager.preferredDynamicTypeSize) { newValue in
            appearanceManager.saveDynamicTypeSize(typeSize: newValue)
        }
    }
    
    private func setAccentColor(color: AccentColor) {
        do {
            try appearanceManager.setAccentColor(color: color)
        } catch {
            handle(error: error)
        }
    }
}

struct SettingsAppearanceView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsAppearanceView()
    }
}
