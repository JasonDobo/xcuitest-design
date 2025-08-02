//
//  String+Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import Foundation

extension String {
    
    func toSnakeCase() -> String {
        return self.lowercased().replacingOccurrences(of: " ", with: "_")
    }
}
