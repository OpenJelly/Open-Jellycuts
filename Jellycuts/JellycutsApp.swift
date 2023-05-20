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
    let persistenceController = PersistenceController.shared

    init() {
        Logger.shared.setLoggerConfig(config: .init(applicationName: "Hydrogen Reporter", defaultLevel: .info, defaultComplexity: .simple, leadingEmoji: "⚫️"))
    }

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .hydrogenReporter()
        }
    }
}
