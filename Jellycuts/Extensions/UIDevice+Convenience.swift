//
//  UIDevice+Convenience.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/1/23.
//

import UIKit

extension UIDevice {
    static var isIPad: Bool {
        UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static var isMac: Bool {
        UIDevice.current.userInterfaceIdiom == .mac
    }
    
    static var isIPhone: Bool {
        UIDevice.current.userInterfaceIdiom == .phone
    }
}
