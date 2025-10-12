//
//  FeatureSteps.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 28/09/2025.
//

import Foundation
import XCTest

class FeatureSteps: XCTest {
    
    func disableWaitForIdle() {
        guard let applicationProcess = objc_getClass("XCUIApplicationProcess") as? AnyClass else {
            return print("Error: XCUIApplicationProcess not found")
        }
        
        guard let replaced = class_getInstanceMethod(type(of: self), #selector(FeatureSteps.replace)) else {
            return print("Error: replace not found")
        }
        
        let xcode16Selector = Selector((("waitForQuiescenceIncludingAnimationIdle:isPreEvent:")))
        let preXcode16Selector = Selector((("waitForQuiescenceIncludingAnimationIdle:")))
        
        if let xcode16 = class_getInstanceMethod(applicationProcess, xcode16Selector) {
            method_exchangeImplementations(xcode16, replaced)
        } else if let preXcode16 = class_getInstanceMethod(applicationProcess, preXcode16Selector) {
            method_exchangeImplementations(preXcode16, replaced)
        }
    }
    
    @objc
    func replace() {
        return
    }
}
