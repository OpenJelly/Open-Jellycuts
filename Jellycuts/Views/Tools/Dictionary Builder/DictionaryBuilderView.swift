//
//  DictionaryBuilderView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import SwiftUI

struct DictionaryBuilderView: View, ErrorHandler {
    @State internal var lastError: Error?
    @State internal var presentErrorView: Bool = false
    @State internal var shouldPresentView: Bool = true

    @StateObject var dictionaryHandler: DictionaryHandler = DictionaryHandler()
    
    @State var presentCreateDictionary: Bool = false
    @State var newDictionaryName: String = ""
    
    var body: some View {
        List {
            ForEach(dictionaryHandler.dictionaries) { dictionary in
                NavigationLink(dictionary.name) {
                    DictionaryView(dictionary: dictionary)
                        .environmentObject(dictionaryHandler)
                }
            }
        }
        .navigationTitle("Dictionary Builder")
        .toolbar {
            ToolbarItemGroup {
                Button {
                    presentCreateDictionary.toggle()
                } label: {
                    Label(.create)
                        .labelStyle(.iconOnly)
                }

            }
        }
        .alert("Create a new Dictionary", isPresented: $presentCreateDictionary, actions: {
            TextField("Name", text: $newDictionaryName)

            Button("Create", action: {
                do {
                    try dictionaryHandler.createDictionary(named: newDictionaryName)
                } catch {
                    handle(error: error)
                }
            })
            Button("Cancel", role: .cancel, action: {})
        }, message: {
            Text("Please enter the name of the Dictionary.")
        })
        .alert("An Error Occurred", isPresented: $presentErrorView) {
            errorMessageButtons()
        } message: {
            errorMessageContent()
        }
    }
}

struct DictionaryBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DictionaryBuilderView()
        }
    }
}
