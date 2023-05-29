//
//  HomeView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter

struct HomeView: View, ErrorHandler {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Project.name, ascending: true)],
        animation: .default)
    private var projects: FetchedResults<Project>
    
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = true
    
    @State var newJellycutName: String = ""
    @State var presentCreateJellycut: Bool = false
    @State var presentCreationConfirmation: Bool = false
    @State var presentToolsSheet: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(projects) { project in
                    NavigationLink {
                        DocumentView(project: project)
                    } label: {
                        Text(project.name ?? "")
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("Home")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Button {
                        presentToolsSheet.toggle()
                    } label: {
                        Label(.tools)
                            .labelStyle(.iconOnly)
                    }
                    Button {
                        presentCreationConfirmation.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .withToolsSheet(isPresented: $presentToolsSheet)
            .confirmationDialog("Create a new Jellycut", isPresented: $presentCreationConfirmation, actions: {
                Button("Create Jellycut") {
                    presentCreateJellycut.toggle()
                }
                Button("Add File") {
                    
                }
                Button("Import from an iCloud link") {
                    
                }
                Button("Import from Shortcuts App") {
                    
                }
            }, message: {
                Text("Select an option to create a new Jellycut 🪼")
            })
            .alert("Create a new Jellycut", isPresented: $presentCreateJellycut, actions: {
                TextField("Name", text: $newJellycutName)

                Button("Create", action: {
                    addItem(name: newJellycutName)
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
    }
    
    private func addItem(name: String) {
        newJellycutName = ""
        withAnimation {
            let text = "import Shortcuts\n#Color: red, #Icon: shortcuts\n"
            let url = getDocumentsURL().appendingPathComponent(name, conformingTo: .jellycut)
            
            let newItem = Project(context: viewContext)
            newItem.name = name
            newItem.url = url.absoluteString
            
            do {
                try text.write(to: url, atomically: false, encoding: .utf8)
                try viewContext.save()
            } catch {
                handle(error: error)
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            do {
                try offsets.map { projects[$0] }.forEach { project in
                    let url = project.url
                    let fileManager = FileManager.default
                    try fileManager.removeItem(at: URL(string: url!)!)
                    
                    viewContext.delete(project)
                }

                try viewContext.save()
            } catch {
                handle(error: error)
            }
        }
    }
    
    private func getDocumentsURL() -> URL {
        let icloudURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        if let icloudURL {
            return icloudURL
        }
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

