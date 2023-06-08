//
//  Color+Codable.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

extension Color: Codable {
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        let archive = try NSKeyedArchiver.archivedData(withRootObject: UIColor(self), requiringSecureCoding: true)
        try container.encode(archive)
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let data = try container.decode(Data.self)
        
        guard let object = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data) else {
            throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid object")
        }
        
        self = Color(uiColor: object)
    }
}
