//
//  DictionaryView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import SwiftUI

struct DictionaryView: View {
    @EnvironmentObject var dictionaryBuilder: DictionaryHandler
    @State var dictionary: DictionaryHandler.JellycutsDictionary
    @State var presentAddItem: Bool = false
    @State var presentEditItem: Bool = false
    @State var updateNothing: Bool = false
    @State var editingItem: (key: String, value: DictionaryHandler.JellycutsDictionary.Value)? = nil
    
    var body: some View {
        List {
            ForEach(dictionary.dictionary.sorted(by: { sortValues(lhs: $0, rhs: $1) }), id: \.key) { item in
                switch item.value.type {
                case .boolean, .string, .number:
                    Button {
                        editingItem = item
                        presentEditItem.toggle()
                    } label: {
                        valueCell(item: item)
                    }
                case .dictionary, .array:
                    // TODO: Implement Editing Dictionaries and Arrays
                    Text(item.key)
                }
            }
        }
        .background {
            // TODO: Fix this so we do not need to do this hack.
            // Needed to make SwiftUI Update itself
            if updateNothing {
                EmptyView()
            }
        }
        .navigationTitle(dictionary.name)
        .toolbar {
            ToolbarItemGroup {
                Button {
                    presentAddItem.toggle()
                } label: {
                    Label(.create)
                        .labelStyle(.iconOnly)
                }
            }
        }
        .sheet(isPresented: $presentEditItem, onDismiss: {
            updateNothing.toggle()
            editingItem = nil
        }) {
            if let item = editingItem {
                DictionaryAddValueSheet(dictionary: $dictionary, key: item.key, valueType: item.value.type, booleanValue: item.value.boolean ?? false, stringValue: item.value.string ?? "", numberValue: item.value.number ?? 0.0)
            } else {
                DictionaryAddValueSheet(dictionary: $dictionary)
            }
        }
        .sheet(isPresented: $presentAddItem, onDismiss: {
            updateNothing.toggle()
        }) {
            DictionaryAddValueSheet(dictionary: $dictionary)
        }
    }
    
    @ViewBuilder
    private func valueCell(item: (key: String, value: DictionaryHandler.JellycutsDictionary.Value)) -> some View {
        HStack {
            VStack {
                Text(item.key)
                    .foregroundColor(.primary)
            }
            Spacer()
            Text("Edit")
        }
    }

    
    private func sortValues(lhs: (key: String, value: DictionaryHandler.JellycutsDictionary.Value), rhs: (key: String, value: DictionaryHandler.JellycutsDictionary.Value)) -> Bool {
        return lhs.key > rhs.key
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        if let dictionary = DictionaryHandler().dictionaries.first {
            NavigationView {
                DictionaryView(dictionary: dictionary)
                    .environmentObject(DictionaryHandler())
            }
        } else {
            Text("No Dictionaries")
        }
    }
}
