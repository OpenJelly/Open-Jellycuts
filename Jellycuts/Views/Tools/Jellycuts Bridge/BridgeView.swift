//
//  BridgeView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import SwiftUI

struct BridgeView: View, ErrorHandler {
    @EnvironmentObject private var appearanceManager: AppearanceManager
    @Environment(\.managedObjectContext) private var viewContext
    
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = false
    
    @StateObject var editorConfig: RunestoneEditorConfig
    @StateObject var socket: WebSocket
    @StateObject var viewModel = BridgeViewModel()

    var bridgeServer: BridgeServer
    
    @State var isExporting: Bool = false
    @State var isBuilding: Bool = false
    @State var exportedShortcutURL: URL? = nil

    init(bridgeServer: BridgeServer) {
        self.bridgeServer = bridgeServer
        if let serverURL = bridgeServer.url,
           let url = URL(string: "ws://\(serverURL)") {
            self._socket = StateObject(wrappedValue: WebSocket(url))
        } else {
            self._socket = StateObject(wrappedValue: WebSocket(URL(string: "ws://")!))
        }
        
        let config = RunestoneEditorConfig()
        config.lightTheme = AppearanceManager.shared.lightEditorTheme
        config.darkTheme = AppearanceManager.shared.darkEditorTheme
        self._editorConfig = StateObject(wrappedValue: config)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        Text("Status")
                            .font(.headline)
                        HStack(spacing: 5) {
                            switch socket.socketState {
                            case .open:
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.green)
                                Text("Connected")
                            case .closed:
                                Circle()
                                    .frame(width: 15, height: 15)
                                    .foregroundColor(.red)
                                Text("Closed")
                            }
                        }
                    }
                    Spacer()
                    functionButtons()
                        .disabled(socket.socketState == .closed)
                }
                .padding(.horizontal)
                Divider()
                RunestoneEditor(text: $viewModel.text, config: editorConfig)
            }
            ConsoleView(warningCount: $viewModel.warningCount, errorCount: $viewModel.errorCount, consoleText: $viewModel.consoleText)
        }
        .navigationTitle(bridgeServer.name ?? "No Bridge Name")
        .background(Color(uiColor: editorConfig.currentTheme.backgroundColor))
        .toolbarBackground(Color(uiColor: editorConfig.currentTheme.backgroundColor))
        .environment(\.colorScheme, editorConfig.currentTheme.colorScheme)
        .quicklook($exportedShortcutURL)
        .onAppear {
            editorConfig.lightTheme = appearanceManager.lightEditorTheme
            editorConfig.darkTheme = appearanceManager.darkEditorTheme
            
            bridgeServer.lastOpenedDate = .now
            try? viewContext.save()
        }
        .onDisappear {
            socket.disconnect()
        }
        .task {
            do {
                try await socket.receive()
            } catch {
                handle(error: error)
            }
        }
        .onChange(of: appearanceManager.lightEditorTheme) { newValue in
            editorConfig.lightTheme = newValue
        }
        .onChange(of: appearanceManager.darkEditorTheme) { newValue in
            editorConfig.darkTheme = newValue
        }
        .environment(\.colorScheme, editorConfig.currentTheme.colorScheme)
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
        .onChange(of: socket.receivedMessages) { newValue in
            viewModel.text = newValue.last ?? "No Code Pulled From Visual Studio Code"
        }
    }
    
    @ViewBuilder
    private func functionButtons() -> some View {
        VStack {
            Button {
                Task {
                    do {
                        try await socket.send(message: "pull")
                    } catch {
                        handle(error: error)
                    }
                }
            } label: {
                Label(.pullFromServer)
                    .labelStyle(.titleAndIcon)
                    .imageScale(.small)
            }
            .buttonStyle(.bordered)
            HStack {
                Button {
                    Task {
                        isBuilding = true
                        do {
                            try await viewModel.build(bridgeServer)
                        } catch {
                            handle(error: error)
                        }
                        isBuilding = false
                    }
                } label: {
                    if isBuilding {
                        ProgressView()
                    } else {
                        Label(.build)
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                            .symbolVariant(.fill)
                    }
                }
                .buttonStyle(.bordered)
                Button {
                    Task {
                        isExporting = true
                        do {
                            exportedShortcutURL = try await viewModel.compile(bridgeServer)
                        } catch {
                            handle(error: error)
                        }
                        isExporting = false
                    }
                } label: {
                    if isExporting {
                        ProgressView()
                    } else {
                        Label("Compile", image: "spaceship.fill")
                            .labelStyle(.titleAndIcon)
                            .imageScale(.small)
                    }
                }
                .buttonStyle(.bordered)
            }
        }
    }

}

struct BridgeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            BridgeView(bridgeServer: try! PersistenceController.preview.container.viewContext.fetch(BridgeServer.fetchRequest()).first!)
                .withEnvironment()
                .withCustomization()
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        }
    }
}
