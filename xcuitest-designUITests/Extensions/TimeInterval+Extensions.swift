//
//  TimeInterval+Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import Foundation

extension TimeInterval {
    
    static var `default`: TimeInterval {
        1.0
    }

    static var slower: TimeInterval {
        5.0
    }

    static var loading: TimeInterval {
        10.0
    }
}
