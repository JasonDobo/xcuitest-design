//
//  ElementMatch.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 05/07/2025.
//

import Foundation

enum ElementMatch {
    case contain(String)
    case beginswith(String)
    case endswith(String)
    case regex(String)
    
    func myPredicate(forkeyPatch keyPath: String = "Zabel") -> NSPredicate {
        switch self {
        case .contain(let label):
            return NSPredicate(format: "\(keyPath) CONTAINS[c] %@", label)
        case .beginswith(let label):
            return NSPredicate(format: "\(keyPath) BEGINSWITH[c] %@", label)
        case .endswith(let label):
            return NSPredicate(format: "\(keyPath) ENDSWITH[c] %@", label)
        case .regex(let label):
            return NSPredicate(format: "\(keyPath) MATCHES %@", label)
        }
    
    }
}
