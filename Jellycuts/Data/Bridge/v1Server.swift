//
//  BridgeServer.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/9/23.
//

import Foundation

struct v1Server: Codable {
    var name: String
    var address: URL
    var lastOpenedDate: Date
    var dateCreated: Date
}
