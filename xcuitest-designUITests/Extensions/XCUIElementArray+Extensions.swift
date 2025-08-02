//
//  XCUIElementArray+Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/07/2025.
//

import Foundation
import XCTest

// MARK: - XCUIElement Array Extension

extension Array where Element: XCUIElement {
    
    /**
     wait for all XCUIElements to match the expected ElementState and return a bool
     - Parameters
        - `state`: expected element state
        - `timeout`: time to wait for state to match
     - Returns: `true` if all elements successfully reach the `state` within the timeout else return `false`
     */
    @discardableResult
    func waitForAllElements(with state: ElementState, timeout: TimeInterval = .loading) -> Bool {
        guard !self.isEmpty else {
            return false
        }
                
        let predicate = NSPredicate(format: state.rawValue)
        let expectations: [XCTNSPredicateExpectation] = self.map { element in
            return XCTNSPredicateExpectation(predicate: predicate, object: element)
        }
        
        let result = XCTWaiter().wait(for: expectations, timeout: timeout, enforceOrder: false)
        return result == .completed
    }
    
    /**
     wait for first XCUIElement to match the expected ElementState and return the match
     - Parameters
        - `state`: expected element state
        - `timeout`: time to wait for state to match
     - Returns: The `XCUIElement` that first matched the state within the timeout else return `nil`
     */
    @discardableResult
    func waitForFirstElement(with state: ElementState,
                             timeout: TimeInterval = .loading,
                             handler: ((XCUIElement) -> Void)? = nil) -> XCUIElement? {
        guard !self.isEmpty else {
            return nil
        }
        
        let predicate = NSPredicate(format: state.rawValue)
        var expectations: [XCTNSPredicateExpectation]!
        var matchedElement: XCUIElement?
        
        expectations = self.map { element in
            let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
            
            expectation.handler = {
                if matchedElement == nil {
                    matchedElement = element
                    
                    for otherElement in self where otherElement != element {
                        expectations.forEach { $0.fulfill() }
                    }
                }
                
                return true
            }
            return expectation
        }
        
        XCTWaiter().wait(for: expectations, timeout: timeout, enforceOrder: false)
        if let element = matchedElement {
            handler?(element)
        }

        return matchedElement
    }
}
