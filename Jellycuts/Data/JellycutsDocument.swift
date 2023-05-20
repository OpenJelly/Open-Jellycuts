//
//  JellycutsDocument.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import UniformTypeIdentifiers

extension UTType {
    static var jellycut: UTType = UTType("com.zlineman.jelly")!
    static var jellycutAlt: UTType = UTType("com.jellyfish.jellycut")!
}

struct JellycutsDocument: FileDocument {
    var text: String

    init(text: String) {
        self.text = text
    }

    static var readableContentTypes: [UTType] { [.jellycut, .jellycutAlt, .plainText] }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        text = string
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = text.data(using: .utf8)!
        return .init(regularFileWithContents: data)
    }
}
