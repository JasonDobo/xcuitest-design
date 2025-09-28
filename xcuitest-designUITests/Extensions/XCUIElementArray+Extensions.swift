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
     Wait for all XCUIElements to match the expected ElementState and return a bool.
     - Parameters:
        - state: Expected element state. Must be a valid NSPredicate format string.
        - timeout: Time to wait for state to match
     - Returns: `true` if all elements successfully reach the `state` within the timeout, else `false`
     */
    @discardableResult
    func waitForAllElements(with state: ElementState, timeout: TimeInterval = .loading) -> Bool {
        guard !self.isEmpty else {
            return false
        }
        
        let predicate = NSPredicate (format: state.rawValue)
        let expectations = self.map { XCTNSPredicateExpectation(predicate: predicate, object: $0) }
        
        let result = XCTWaiter.wait(for: expectations, timeout: timeout)
        return result == .completed
    }
    
    /**
     Wait for first XCUIElement to match the expected ElementState and return the match.
     Exits as soon as any match occurs, fulfilling all expectations.
     - Parameters:
        - state: Expected element state. Must be a valid NSPredicate format string.
        - timeout: Time to wait for state to match
        - handler: Closure to call with the matched element
     - Returns: The `XCUIElement` that first matched the state within the timeout else return `nil`
     */
    @discardableResult
    func waitForFirstElement(with state: ElementState,
                             timeout: TimeInterval = .loading,
                             handler: ((XCUIElement) -> Void)? = nil) -> XCUIElement? {
        guard !self.isEmpty else { return nil }
        
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
    
    /**
     Wait for first XCUIElement to match the expected ElementState and return the match.
     Exits as soon as any match occurs, fulfilling all expectations.
     - Parameters:
        - state: Expected element state. Must be a valid NSPredicate format string.
        - timeout: Time to wait for state to match
        - handler: Closure to call with the matched element
     - Returns: The `XCUIElement` that first matched the state within the timeout else return `nil`
     */
    func waitForFirst(with state: ElementState,
                             timeout: TimeInterval = .loading,
                             handler: ((XCUIElement) -> Void)? = nil) -> XCUIElement? {
        guard !self.isEmpty else { return nil }
        
        let predicate = NSPredicate(format: state.rawValue)
        var matchedElement: XCUIElement?
        var expectations: [XCTNSPredicateExpectation] = []
        
        expectations = self.map { element in
            let expectation = XCTNSPredicateExpectation(predicate: predicate, object: element)
            expectation.handler = {
                if matchedElement == nil {
                    matchedElement = element
                    expectations.forEach { $0.fulfill() }
                    return true
                }
                return false
            }
            return expectation
        }
                
        _ = XCTWaiter.wait(for: expectations, timeout: timeout)
        if let element = matchedElement { handler?(element) }
        return matchedElement
    }
}
