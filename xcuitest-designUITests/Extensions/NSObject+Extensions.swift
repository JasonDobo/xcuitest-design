//
//  NSObject+Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 28/09/2025.
//

import ObjectiveC.runtime

extension NSObject {
    
    func dumpProperties() {
        var outCount: UInt32 = 0
        guard let list = class_copyPropertyList(type(of: self), &outCount) else {
            print("No properties for \(type(of: self))")
            return
        }
        defer {
            free(list)
        }

        if outCount == 0 {
            print("No properties for \(type(of: self))")
            return
        }

        for i in 0..<Int(outCount) {
            let prop = list[i]
            let name = String(cString: property_getName(prop))
            print("property name: \(name)")

            if let attrs = property_getAttributes(prop) {
                let typeDesc = String(cString: attrs)
                print("property type: \(typeDesc)")
            }
        }
    }
}
