//
//  SettingsBehaviorView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

struct SettingsBehaviorView: View, ErrorHandler {
    @EnvironmentObject private var appearanceManager: AppearanceManager
    
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = false
    
    @State private var hapticsIsOn: Bool
    @State private var inAppBrowser: Bool
    @State private var projectSort: ProjectSort

    @State private var presentPremiumView: Bool = false
    
    init() {
        inAppBrowser = PreferenceManager.getInAppBrowser()
        hapticsIsOn = PreferenceManager.getHapticsEnabled()
        projectSort = PreferenceManager.getProjectSort()
    }
    
    var body: some View {
        Form {
            Section {
                Toggle(isOn: $hapticsIsOn) {
                    Label(.haptics)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    hapticsIsOn.toggle()
                }
                HStack {
                    Label(.browser)
                    Spacer()
                    Menu {
                        Button {
                            inAppBrowser = true
                        } label: {
                            Label(.jellycutsBrowser)
                        }
                        Button {
                            inAppBrowser = false
                        } label: {
                            Label(.safariBrowser)
                        }
                    } label: {
                        if inAppBrowser {
                            Label(.jellycutsBrowser)
                        } else {
                            Label(.safariBrowser)
                        }
                    }
                }
                HStack {
                    Label(.projectSort)
                    Spacer()
                    Menu {
                        ForEach(ProjectSort.allCases, id: \.rawValue) { sortMode in
                            Button(sortMode.rawValue) {
                                if PurchaseHandler.isProMode {
                                    projectSort = sortMode
                                    PreferenceManager.saveProjectSort(sort: sortMode)
                                } else {
                                    presentPremiumView.toggle()
                                }
                            }
                        }
                    } label: {
                        Text(projectSort.rawValue)
                    }
                }

            }
            .onAppear {
                inAppBrowser = PreferenceManager.getInAppBrowser()
                hapticsIsOn = PreferenceManager.getHapticsEnabled()
                projectSort = PreferenceManager.getProjectSort()
            }
        }
        .withProSheet(isPresented: $presentPremiumView)
        .onChange(of: hapticsIsOn, perform: { newValue in
            PreferenceManager.saveHaptics(enabled: newValue)
        })
        .onChange(of: inAppBrowser, perform: { newValue in
            PreferenceManager.saveInAppBrowser(shouldUse: newValue)
        })
        .navigationTitle("Behavior")
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
    }
}

struct SettingsBehaviorView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsBehaviorView()
    }
}
