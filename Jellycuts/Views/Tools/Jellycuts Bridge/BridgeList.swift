//
//  BridgeList.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import SwiftUI

struct BridgeList: View, ErrorHandler {
    @Environment(\.managedObjectContext) private var viewContext
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = false

    @FetchRequest(sortDescriptors: [], animation: .default)
    private var bridgeServers: FetchedResults<BridgeServer>

    @State private var newBridgeName: String = ""
    @State private var newBridgeAddress: String = ""
    @State private var presentAddBridge: Bool = false

    var body: some View {
        List {
            ForEach(bridgeServers) { server in
                NavigationLink {
                    BridgeView(bridgeServer: server)
                        .withEnvironment()
                } label: {
                    VStack(alignment: .leading) {
                        Text(server.name ?? "No Server Name")
                        Text(server.url ?? "No Address")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
        .navigationTitle("Bridge Servers")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button {
                    presentAddBridge.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .alert("Add New Bridge Location", isPresented: $presentAddBridge, actions: {
            TextField("Name", text: $newBridgeName)
            TextField("Address", text: $newBridgeAddress)

            Button("Create", action: {
                addServer(name: newBridgeName, address: newBridgeAddress)
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter the name of the Jellycut.")
        })
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
    }
    
    private func addServer(name: String, address: String) {
        newBridgeName = ""
        withAnimation {
            do {
                let newBridge = BridgeServer(context: viewContext)
                newBridge.name = name
                newBridge.url = address
                newBridge.dateCreated = .now
                newBridge.lastOpenedDate = .now
                
                try viewContext.save()
            } catch {
                handle(error: error)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            do {
                offsets.map { bridgeServers[$0] }.forEach { viewContext.delete($0) }
                try viewContext.save()
            } catch {
                handle(error: error)
            }
        }
    }
}

struct BridgeList_Previews: PreviewProvider {
    static var previews: some View {
        BridgeList()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
