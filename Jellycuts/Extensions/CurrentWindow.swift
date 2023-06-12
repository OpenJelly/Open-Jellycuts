//
//  CurrentWindow.swift
//  Jellycuts
//
//  Created by Taylor Lineman on 6/12/23.
//

import UIKit

/// https://stackoverflow.com/a/69683349/14886210
public extension UIApplication {
    func currentUIWindow() -> UIWindow? {
        let connectedScenes = UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .compactMap { $0 as? UIWindowScene }
        
        let window = connectedScenes.first?.windows.first { $0.isKeyWindow }

        return window
    }
}
