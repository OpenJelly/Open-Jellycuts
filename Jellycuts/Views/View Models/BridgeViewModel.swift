//
//  BridgeViewModel.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import SwiftUI
import Open_Jellycore

class BridgeViewModel: ObservableObject {
    @Published var text: String = "No Code Pulled From Visual Studio Code"

    @Published var warningCount: Int = 0
    @Published var errorCount: Int = 0
    @Published var consoleText: NSAttributedString = NSAttributedString()

    init() {
//        if UserDefaults.standard.object(forKey: "servers") != nil {
//            let storedObject: Data = UserDefaults.standard.object(forKey: "servers") as? Data ?? Data()
//            let storedList: [v1Server]? = try? PropertyListDecoder().decode([v1Server].self, from: storedObject)
//
//            bridgeServer = storedList ?? []
//            bridgeServer.sort { (pr1, pr2) -> Bool in
//                return pr1.lastOpenedDate.timeIntervalSince1970 > pr2.lastOpenedDate.timeIntervalSince1970
//            }
//        }
    }
    
    func build(_ server: BridgeServer) async throws {
        ErrorReporter.shared.reset()
        try await compile(server)
        await updateConsole()
    }
        
    @discardableResult
    func compile(_ server: BridgeServer) async throws -> URL? {
        ErrorReporter.shared.reset()
        let parser = Parser(contents: text)
        try parser.parse()
        
        let compiler = Compiler(parser: parser)
        let shortcut = try compiler.compile(named: server.name ?? "Unnamed Jellycut")

        await updateConsole()
        
        if !ErrorReporter.shared.errors.isEmpty {
            print("Found \(ErrorReporter.shared.errors.count) errors")
            for error in ErrorReporter.shared.errors {
                print(error.errorDescription ?? "No Description", error.recoverySuggestion ?? "No Suggestion")
            }
            
            return nil
        } else {
            print("Successfully Compiled Shortcut")
            
            var url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("shortcuts", isDirectory: true)
            try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
            
            url.appendPathComponent(server.name ?? "NoName")
            url.appendPathExtension("shortcut")

            let exportURL = try await ShortcutsSigner.sign(fileURL: url, shortcut: shortcut)
            
            return exportURL
        }
    }
    
    @MainActor
    func updateConsole() {
        errorCount = ErrorReporter.shared.numberOfErrors
        warningCount = ErrorReporter.shared.numberOfWarnings
        consoleText = ErrorReporter.shared.getErrorText()
    }

//    func addServer(name: String, address: URL) {
//        let server = Server(name: name, address: address, lastOpenedDate: Date(), dateCreated: Date())
//        servers.append(server)
//        saveServers()
//    }
//
//    func saveServers() {
//        UserDefaults.standard.set(try? PropertyListEncoder().encode(servers), forKey: "servers")
//    }
//
//    func deleteServer(index: Int) {
//        servers.remove(at: index)
//        saveServers()
//    }
//
//    func renameServer(index: Int, name: String) {
//        servers[index].name = name
//        saveServers()
//    }
//
//    func updateEditedDate(index: Int) {
//        servers[index].lastOpenedDate = Date()
//        saveServers()
//    }

}
