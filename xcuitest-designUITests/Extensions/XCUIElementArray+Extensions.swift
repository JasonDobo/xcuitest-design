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
        
        let myPredicate = NSPredicate (format: state.rawValue)
        var allExpectations: [XCTNSPredicateExpectation]!
        allExpectations = self.map { element -> XCTNSPredicateExpectation in
            return XCTNSPredicateExpectation (predicate: myPredicate, object: element)
        }
        
        let result = XCTWaiter().wait(for: allExpectations, timeout: timeout, enforceOrder: false)
        return result == XCTWaiter.Result.completed
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
        
        let myPredicate = NSPredicate(format: state.rawValue)
        var allExpectations: [XCTNSPredicateExpectation]!
        var matchedElement: XCUIElement?
        
        allExpectations = self.map { element -> XCTNSPredicateExpectation in
            let myHandler: () -> Bool = {
                if matchedElement != nil {
                    return true
                }
                
                matchedElement = element
                allExpectations.forEach { $0.fulfill() }
                return true
            }
            
            let myXCTNSPredicateExpectation = XCTNSPredicateExpectation(predicate: myPredicate, object: element)
            myXCTNSPredicateExpectation.handler = myHandler
            
            return myXCTNSPredicateExpectation
        }
        
        XCTWaiter().wait(for: allExpectations, timeout: timeout)
        if let matchedElement = matchedElement {
            handler?(matchedElement)
        }
        
        return matchedElement
    }
}
