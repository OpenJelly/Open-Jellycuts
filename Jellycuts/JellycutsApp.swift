//
//  JellycutsApp.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter

@main
struct JellycutsApp: App {
    @StateObject var appearanceManager = AppearanceManager.shared
    let persistenceController = PersistenceController.shared

    init() {
        Logger.shared.setLoggerConfig(config: .init(applicationName: "Jellycuts", defaultLevel: .info, defaultComplexity: .simple, leadingEmoji: "🪼"))
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .rounded()
                .tint(appearanceManager.accentColor.color)
                .preferredColorScheme(appearanceManager.colorScheme == .system ? nil : (appearanceManager.colorScheme == .light ? .light : .dark))
                .dynamicTypeSize(appearanceManager.preferredDynamicTypeSize)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .withEnvironment()
                .hydrogenReporter()
        }
    }
}
