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
    
    static func createJellyDocument(name: String, viewContext: NSManagedObjectContext) throws {
        let text = "import Shortcuts\n#Color: red, #Icon: shortcuts\n"
        let url = getDocumentsURL().appendingPathComponent(name, conformingTo: .jellycut)
        
        let newProject = Project(context: viewContext)
        newProject.name = name
        newProject.urlType = StoreURLType.iCloud.rawValue
        newProject.url = url.lastPathComponent
        let writeURL = try getProjectURL(for: newProject)
        
        try text.write(to: writeURL, atomically: false, encoding: .utf8)
        try viewContext.save()
    }
    
    static func deleteProjects(offsets: IndexSet, viewContext: NSManagedObjectContext, projects: FetchedResults<Project>) throws {
        try offsets.map { projects[$0] }.forEach { project in
            let fileManager = FileManager.default
            try fileManager.removeItem(at: getProjectURL(for: project))
            
            viewContext.delete(project)
        }

        try viewContext.save()
    }
    
    static func getProjectURL(for project: Project) throws -> URL {
        if project.urlType == StoreURLType.iCloud.rawValue {
            let documentURL = getDocumentsURL().appendingPathComponent(project.url!)
            return documentURL
        } else {
            guard let url = URL(string: project.url!) else {
                throw DocumentHandlingError.invalidFileURL
            }
            return url
        }
    }
    
    static func writeContents(for project: Project, text: String) throws {
        
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
