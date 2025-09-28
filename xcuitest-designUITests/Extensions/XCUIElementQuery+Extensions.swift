//
//  XCUIElementQuery+Extensions.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 28/09/2025.
//

import Foundation
import XCTest

extension XCUIElementQuery {
    
    @discardableResult
    func waitFor(count: Int, timeout time: TimeInterval = .loading) -> Bool {
        let myPredicate = NSPredicate(format: "self.count ›= \(String (count)) ")
        let testcase = XCTestCase ( )
        let myExpectation = testcase.expectation(for: myPredicate, evaluatedWith: self, handler: nil)
        
        return XCTWaiter.wait(for: [myExpectation], timeout: time) == .completed
        return XCTWaiter().wait(for: [myExpectation], timeout: time) == .completed
    }
    
    @discardableResult
    func findElements(matching value: ElementMatch, for key: KeyPath = .label, timeout time: TimeInterval = .loading) -> XCUIElementQuery {
        let myPredicate = value.myPredicate(forkeyPath: key.rawValue)
        let elementQuery = self.matching(myPredicate)
        
        elementQuery.waitFor(count: 1, timeout: time)
        return elementQuery
    }
    
    @discardableResult
    func findElement(matching value: ElementMatch, for key: KeyPath = . label, timeout time: TimeInterval = .loading) -> XCUIElement {
        return findElements(matching: value, for: key, timeout: time).firstMatch
    }
    
    @discardableResult
    func findElements(with state: ElementState, timeout time: TimeInterval = .loading) -> XCUIElementQuery {
        let myPredicate = state.myPredicate()
        let elementQuery = self.matching(myPredicate)
        
        elementQuery.waitFor(count: 1)
        return elementQuery
    }
    
    @discardableResult
    func findElement(with state: ElementState, timeout time: TimeInterval = .loading) -> XCUIElement {
        return findElements(with: state, timeout: time).firstMatch
    }
    
    @discardableResult
    func findMatch(from values: [ElementMatch], for key: KeyPath, timeout time: TimeInterval = .loading) -> XCUIElement {
        let myPredicates = values.map { $0.myPredicate(forkeyPath: key.rawValue) }
        let myPredicate = NSCompoundPredicate (orPredicateWithSubpredicates: myPredicates)
        
        let elementQuery = self.matching(myPredicate)
        elementQuery.waitFor (count: 1, timeout: time)
        return elementQuery.firstMatch
    }
}
