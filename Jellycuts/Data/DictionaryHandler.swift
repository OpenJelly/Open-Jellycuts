//
//  DictionaryHandler.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 5/29/23.
//

import HydrogenReporter
import Foundation

class DictionaryHandler: ObservableObject {
    enum DictionaryError: LocalizedError {
        case nameAlreadyExists
        case dictionaryDoesNotExist
        case keyAlreadyExists
        
        var errorDescription: String? {
            switch self {
            case .nameAlreadyExists:
                return "Unable too set name because a dictionary with the same name already exists."
            case .dictionaryDoesNotExist:
                return "The dictionary you are attempting to change does not exist."
            case .keyAlreadyExists:
                return "The key you are attempting to add already exists. Please pick another key."
            }
        }
    }

    class JellycutsDictionary: Codable, Identifiable {
        var id: String {
            name
        }
        
        var name: String
        var dictionary: [String: Value]
        
        init(name: String, dictionary: [String : Value]) {
            self.name = name
            self.dictionary = dictionary
        }
        
        func set(key: String, value: Value) throws {
            self.dictionary[key] = value
        }
        
        class Value: Codable, Identifiable {
            enum ValueType: String, CaseIterable, Codable {
                case boolean = "Boolean"
                case string = "String"
                case number = "Number"
                case array = "Array"
                case dictionary = "Dictionary"
                
                var imageName: String {
                    switch self {
                    case .boolean:
                        return "01.square"
                    case .string:
                        return "a.square"
                    case .number:
                        return "number.square"
                    case .array:
                        return "square.grid.3x3.square"
                    case .dictionary:
                        return "curlybraces.square"
                    }
                }
            }
            
            var id: UUID  {
                return UUID()
            }
            
            var type: ValueType
            var boolean: Bool?
            var string: String?
            var number: Double?
            var array: [Value]?
            var dictionary: [String: Value]?
            
            init(type: ValueType, boolean: Bool? = nil, string: String? = nil, number: Double? = nil, array: [Value]? = nil, dictionary: [String : Value]? = nil) {
                self.type = type
                self.boolean = boolean
                self.string = string
                self.number = number
                self.array = array
                self.dictionary = dictionary
            }
        }
    }
     
    @Published var dictionaries: [JellycutsDictionary] = []
    
    init() {
        loadDictionaries()
    }
    
    private func loadDictionaries() {
        do {
            guard let dictionaryData = SharedDataStorageManager.defaults.data(forKey: DefaultsKeys.dictionaryBuilderKey) else {
                LOG("No dictionary data available", level: .warn)
                return
            }
            
            dictionaries = try PropertyListDecoder().decode([JellycutsDictionary].self, from: dictionaryData)
        } catch {
            LOG("Dictionary Decoding Failed", error, level: .error)
        }
    }
    
    private func nameMatches(dictionary: JellycutsDictionary, name: String) -> Bool {
        return dictionary.name == name
    }
}

// MARK: All user facing functions of the dictionary handler
extension DictionaryHandler {
    func saveDictionaries() throws {
        let data = try PropertyListEncoder().encode(dictionaries)
        SharedDataStorageManager.defaults.set(data, forKey: DefaultsKeys.dictionaryBuilderKey)
    }
    
    func createDictionary(named name: String) throws {
        if dictionaries.contains(where: { nameMatches(dictionary: $0, name: name) }) {
            throw DictionaryError.nameAlreadyExists
        }
        
        dictionaries.append(JellycutsDictionary(name: name, dictionary: [:]))
        try saveDictionaries()
    }
    
//    func editDictionary(named name: String, newDictionary: JellycutsDictionary) throws {
//        if !dictionaries.contains(where: { nameMatches(dictionary: $0, name: name) }) {
//            throw DictionaryError.dictionaryDoesNotExist
//        }
//
//        dictionaries.append(newDictionary)
//        try saveDictionaries()
//    }
    
    func deleteDictionary(named name: String) throws {
        if !dictionaries.contains(where: { nameMatches(dictionary: $0, name: name) }) {
            throw DictionaryError.dictionaryDoesNotExist
        }

        dictionaries.removeAll(where: { nameMatches(dictionary: $0, name: name) })
        try saveDictionaries()
    }
}
