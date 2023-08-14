//
//  ArrayView.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import SwiftUI

struct ArrayView: View {
    @EnvironmentObject var dictionaryHandler: DictionaryHandler
    @Binding var dictionary: DictionaryHandler.JellycutsDictionary
    @State var key: String?
    @State var parentKey: String?
    @State var valueArray: [DictionaryHandler.JellycutsDictionary.Value]
    @State var presentAddItem: Bool = false
    @State var presentEditItem: Bool = false
    @State var updateNothing: Bool = false
    @State var editingItem: DictionaryHandler.JellycutsDictionary.Value? = nil
    
    var body: some View {
        List {
            ForEach(valueArray) { item in
                switch item.type {
                case .boolean, .string, .number:
                    Button {
                        editingItem = item
                    } label: {
                        valueCell(item: item)
                    }
                case .dictionary:
                    // TODO: Implement Editing Dictionaries and Arrays
                    if let dictionary = item.dictionary {
                        NavigationLink {
                            DictionaryView(dictionary: dictionary)
                                .environmentObject(dictionaryHandler)
                        } label: {
                            valueCell(item: item)
                        }
                    } else {
                        Text("Invalid Dictionary")
                    }
                case .array:
                    if let array = item.array {
                        NavigationLink {
                            ArrayView(dictionary: $dictionary, key: nil, parentKey: key ?? parentKey ?? "NO_KEY", valueArray: array)
                                .environmentObject(dictionaryHandler)
                        } label: {
                            valueCell(item: item)
                        }
                    } else {
                        Text("Invalid Array")
                    }
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
        .navigationTitle(key ?? "Array")
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
        .sheet(item: $editingItem, onDismiss: {
            if let key {
                self.valueArray = dictionary.dictionary[key]?.array ?? valueArray
            } else if let parentKey {
                dictionary.dictionary[parentKey]?.array = valueArray
            }
            updateNothing.toggle()
            editingItem = nil
        }) { item in
            if let key {
                DictionaryAddValueSheet(dictionary: $dictionary, array: .constant([]), editingInArray: true, key: key, valueType: item.type, booleanValue: item.boolean ?? false, stringValue: item.string ?? "", numberValue: item.number ?? 0.0)
            } else if let parentKey {
                DictionaryAddValueSheet(dictionary: $dictionary, array: $valueArray, editingInArray: true, hasParentKey: true, key: parentKey, valueType: item.type, booleanValue: item.boolean ?? false, stringValue: item.string ?? "", numberValue: item.number ?? 0.0)
            } else {
                DictionaryAddValueSheet(dictionary: $dictionary, array: $valueArray, editingInArray: true, key: "INSIDE_ARRAY", valueType: item.type, booleanValue: item.boolean ?? false, stringValue: item.string ?? "", numberValue: item.number ?? 0.0)
            }
        }
        .sheet(isPresented: $presentAddItem, onDismiss: {
            if let key {
                self.valueArray = dictionary.dictionary[key]?.array ?? valueArray
            } else if let parentKey {
                self.valueArray = dictionary.dictionary[parentKey]?.array ?? valueArray
            }
            updateNothing.toggle()
        }) {
            if let key {
                DictionaryAddValueSheet(dictionary: $dictionary, array: .constant([]), editingInArray: true, key: key)
            } else if let parentKey {
                DictionaryAddValueSheet(dictionary: $dictionary, array: $valueArray, editingInArray: true, hasParentKey: true, key: parentKey)
            } else {
                Text("Invalid Dictionary Structure")
            }
        }
    }
    
    @ViewBuilder
    private func valueCell(item: DictionaryHandler.JellycutsDictionary.Value) -> some View {
        HStack {
            VStack {
                Text(item.type.rawValue)
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

struct ArrayView_Previews: PreviewProvider {
    static var previews: some View {
        if let dictionary = DictionaryHandler().dictionaries.first {
            NavigationView {
                ArrayView(dictionary: .constant(dictionary), key: "test", valueArray: [])
                    .environmentObject(DictionaryHandler())
            }
        } else {
            Text("No Dictionaries")
        }
    }
}
