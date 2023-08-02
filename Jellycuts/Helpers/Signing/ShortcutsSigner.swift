//
//  ShortcutsSigner.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/30/23.
//

import Foundation
import UniformTypeIdentifiers

struct ShortcutsSigner {
    enum SigningError: LocalizedError {
        case networkUnreachable
        case invalidXCallbackURL
        case serverError(error: String)
        
        var errorDescription: String? {
            switch self {
            case .networkUnreachable:
                return "The network is not reachable"
            case .invalidXCallbackURL:
                return "The XCallbackURL was not valid"
            case .serverError(let error):
                return "There was an error with the signing server (\(error))"
            }
        }
        
        var recoverySuggestion: String? {
            switch self {
            case .networkUnreachable:
                return "Please check your network connection and try again."
            case .invalidXCallbackURL:
                return "Please ensure that your Jellycut is properly named."
            case .serverError(_):
                return "Check your network connection, and try again later."
            }
        }
    }
    
    /// Signs a shortcut file and returns the XCallback URL to open the Jellycuts helper and import the given shortcut.
    static func sign(fileURL: URL, shortcut: String) async throws -> URL {
        var url = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("shortcuts", isDirectory: true)
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: [:])
        
        url.appendPathComponent(fileURL.deletingPathExtension().lastPathComponent)
        url.appendPathExtension("shortcut")
        
        try shortcut.write(toFile: url.path, atomically: true, encoding: .utf8)
        
        return try await sign_iOS(fileURL: url)
    }
        
    private static func sign_iOS(fileURL: URL) async throws -> URL {
        if Network.reachability.isConnectedToNetwork {
            let boundary = UUID().uuidString
            let fileName = fileURL.lastPathComponent
            let mimetype = mimeType(for: fileName)

            let paramName = "upload"
            let fileData = try? Data(contentsOf: fileURL)
            var data = Data()
            
            data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
            data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
            data.append("Content-Type: \(mimetype)\r\n\r\n".data(using: .utf8)!)
            data.append(fileData!)
            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

            var request = URLRequest(url: Links.signingURL)
            request.httpMethod = "POST"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            request.setValue(String(data.count), forHTTPHeaderField: "Content-Length")
            
            let (responseData, _) = try await URLSession.shared.upload(for: request, from: data)
            try deleteFile(fileURL: fileURL)
            
            if let errorString = String(data: responseData, encoding: .utf8) {
                throw SigningError.serverError(error: errorString)
            } else {
                try responseData.write(to: fileURL)
                return fileURL
            }
        } else {
            throw SigningError.networkUnreachable
        }
    }
    
    private static func deleteFile(fileURL: URL) throws {
        if FileManager.default.fileExists(atPath: fileURL.path) {
            try FileManager.default.removeItem(atPath: fileURL.path)
        }
    }

    private static func mimeType(for path: String) -> String {
        let pathExtension = URL(fileURLWithPath: path).pathExtension
        guard let uti = UTType(filenameExtension: pathExtension),
              let mimetype = uti.preferredMIMEType
        else {
            return "application/octet-stream"
        }
        
        return mimetype
    }
}
