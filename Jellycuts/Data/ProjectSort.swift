//
//  ProjectSort.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/7/23.
//

import SwiftUI

enum ProjectSort: String, CaseIterable {
    case azName = "Name (a-z)"
    case zaName = "Name (z-a)"
    case creationOldestNewest = "Creation Date (oldest - newest)"
    case creationNewestOldest = "Creation Date (newest - oldest)"
    case recentlyOpened = "Recently Opened"
    case leastRecentlyOpened = "Least Recently Opened"
}
