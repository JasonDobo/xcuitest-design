//
//  ElementMatch.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 05/07/2025.
//

import Foundation

enum ElementMatch {
    case contain(String)
    case notContain(String)
    case beginswith(String)
    case endswith(String)
    case regex(String)
    
    func myPredicate(forkeyPath keyPath: String = "label") -> NSPredicate {
        switch self {
        case .contain(let label):
            return NSPredicate(format: "\(keyPath) CONTAINS[c] %@", label)
        case .notContain(let label):
            return NSPredicate(format: "NOT \(keyPath) CONTAINS[c] %@", label)
        case .beginswith(let label):
            return NSPredicate(format: "\(keyPath) BEGINSWITH[c] %@", label)
        case .endswith(let label):
            return NSPredicate(format: "\(keyPath) ENDSWITH[c] %@", label)
        case .regex(let label):
            return NSPredicate(format: "\(keyPath) MATCHES %@", label)
        }
    }
    
    func myPredicate(forKeyPath keyPath: KeyPath = .label) -> NSPredicate {
        switch self {
        case .contain(let label):
            return NSPredicate(format: "\(keyPath.rawValue) CONTRAINS[c] %@", label)
        case .notContain(let label):
            return NSPredicate(format: "\(keyPath.rawValue) CONTRAINS[c] %@", label)
        case .beginswith(let label):
            return NSPredicate(format: "\(keyPath.rawValue) CONTRAINS[c] %@", label)
        case .endswith(let label):
            return NSPredicate(format: "\(keyPath.rawValue) ENDSWITH[c] %@", label)
        case .regex(let label):
            return NSPredicate(format: "\(keyPath.rawValue) MATCHES %@", label)
        }
    }
}
