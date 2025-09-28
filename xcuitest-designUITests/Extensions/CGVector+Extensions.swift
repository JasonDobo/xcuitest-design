//
//  CGVector+Extensions.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 28/09/2025.
//

import Foundation

extension CGVector {
    // Half way across the screen and 10% from top
    static let topOffset = CGVector(dx: 0.5, dy: 0.10)
    static let proMaxOffset = CGVector(dx: 0.5, dy: 0.14)
    static let plusOffset = CGVector(dx: 0.5, dy: 0.10)
    
    // Half way across the screen and 90% from top
    static let bottomOffset = CGVector(dx: 0.5, dy: 0.9)
    static let middleOffset = CGVector(dx: 0.5, dy: 0.5)
    
    // Use this offset to tap outside the sidebar in order to close it
    static let sidebarOffset = CGVector(dx: 0.75, dy: 0.5)
}
