//
//  ElementState.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import Foundation

enum ElementState: String {
    case enabled = "enabled == true"
    case notEnabled = "enabled == false"
    case exists = "exists == true"
    case notExists = "exists == false"
    case hittable = "hittable == true"
    case notHittable = "hittable == false"
    case selected = "selected == true"
    case notSelected = "selected == false"
    case keyboardFocus = "hasKeyboardFocus == true"
    case notKeyboardFocus = "hasKeyboardFocus == false"
    
    func myPredicate() -> NSPredicate {
        return NSPredicate(format: self.rawValue)
    }
}
