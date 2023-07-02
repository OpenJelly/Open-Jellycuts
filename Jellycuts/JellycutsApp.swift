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
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @StateObject var appearanceManager = AppearanceManager.shared
    let persistenceController = PersistenceController.shared
    
    init() {
        Logger.shared.setLoggerConfig(config: .init(applicationName: "Jellycuts", defaultLevel: .info, defaultComplexity: .simple, leadingEmoji: "🪼"))
        switch Config.appConfiguration {
        case .AppStore:
            break
        case .Debug:
            AppIconManager.unlockHiddenIcon(hidden: .dev)
        case .TestFlight:
            AppIconManager.unlockHiddenIcon(hidden: .beta)
        }
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

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        
        return sceneConfig
    }
    
}

class SceneDelegate: NSObject, UIWindowSceneDelegate {
    
}
