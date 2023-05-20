//
//  ErrorHandler.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/16/23.
//

import SwiftUI
import HydrogenReporter

protocol ErrorHandler {
    var lastError: Error? { get nonmutating set }
    var presentErrorView: Bool { get nonmutating set }
    var shouldPresentView: Bool { get nonmutating set }
}

extension ErrorHandler {
    func handle(error: Error) {
        lastError = error
        LOG("[Error Handler]: Handling: \(error.localizedDescription), \(error)", level: .error)
        if shouldPresentView || error.localizedDescription == "Too many requests" {
            presentErrorView = true
        }
    }
    
    @ViewBuilder
    func errorMessageButtons() -> some View {
        Button("Ok", role: .cancel) { }
    }
    
    @ViewBuilder
    func errorMessageContent() -> some View {
        if let lastError {
            Text(lastError.localizedDescription)
        } else {
            Text("Unknown Error")
        }
    }
}
