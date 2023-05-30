//
//  Dispatch.swift
//  Jellyfish
//
//  Created by Taylor lineman on 8/14/20.
//

import Foundation

// An extension that makes it easy to use background threads.
typealias Dispatch = DispatchQueue

extension Dispatch {
    
    static func background(_ task: @escaping () -> Void) {
        Dispatch.global(qos: .background).async {
            task()
        }
    }
    
    static func main(_ task: @escaping () -> Void) {
        Dispatch.main.async {
            task()
        }
    }
    
    static func delay(seconds: Double, _ task: @escaping () -> Void) {
        Dispatch.main.asyncAfter(deadline: .now() + seconds) {
            task()
        }
    }
    
    static func utilityTask(_ task: @escaping () -> Void) {
        DispatchQueue(label: "UtilityTask", qos: .utility, attributes: .concurrent).async {
            task()
        }
    }
}
