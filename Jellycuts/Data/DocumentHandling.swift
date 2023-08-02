//
//  DocumentHandling.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/31/23.
//

import CoreData
import UniformTypeIdentifiers
import SwiftUI
import HydrogenReporter

struct DocumentHandling {
    enum DocumentHandlingError: LocalizedError {
        case invalidFileURL
    }
    
    static func importJellyDocument(url: URL, viewContext: NSManagedObjectContext) throws {
        let name = url.deletingPathExtension().lastPathComponent
        
        let newProject = Project(context: viewContext)
        newProject.name = name
        newProject.creationDate = .now
        newProject.url = url.path()
        
        try viewContext.save()
    }
    
    static func createJellyDocument(name: String, viewContext: NSManagedObjectContext) throws {
        let text = "import Shortcuts\n#Color: red, #Icon: shortcuts\n"
        
        let newProject = Project(context: viewContext)
        newProject.name = name
        newProject.creationDate = .now
        let writeURL = try getProjectURL(for: newProject)
        
        try text.write(to: writeURL, atomically: false, encoding: .utf8)
        try viewContext.save()
    }
    
    static func deleteProjects(offsets: IndexSet, viewContext: NSManagedObjectContext, projects: FetchedResults<Project>) throws {
        offsets.map { projects[$0] }.forEach { project in
            let fileManager = FileManager.default
            try? fileManager.removeItem(at: getProjectURL(for: project))
            
            viewContext.delete(project)
        }

        try viewContext.save()
    }
    
    static func getProjectURL(for project: Project) throws -> URL {
        if let projectURL = project.url?.removingPercentEncoding {
            return URL(filePath: projectURL)
        } else {
            let newURLBase = getDocumentsURL().appendingPathComponent(project.name ?? "No Name", conformingTo: .jellycut)

            return newURLBase
        }
    }
    
    static func writeContents(for project: Project, text: String) throws {
        let writeURL = try getProjectURL(for: project)
        
        try text.write(to: writeURL, atomically: false, encoding: .utf8)
    }
    
    private static func getDocumentsURL() -> URL {
        let icloudURL = FileManager.default.url(forUbiquityContainerIdentifier: nil)?.appendingPathComponent("Documents")
        if let icloudURL {
            return icloudURL
        }
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
