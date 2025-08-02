//
//  XCUIElement + Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import Foundation
import XCTest

extension XCUIElement {
    
    /**
     wait for element to match the expected state and return a bool
     - Paramter state: expected element state
     - Paramater time: time to wait for state to match
     */
    @discardableResult
    func wait(for state: ElementState, waiting time: TimeInterval = .default, handler: ((XCUIElement) -> Void)? = nil) -> Bool {
        guard state != .exists else {
            return self.waitForExistence(timeout: time)
        }
        
        let myPedicate = NSPredicate(format: state.rawValue)
        let testCase = XCTestCase()
        let myExpectation = testCase.expectation(for: myPedicate, evaluatedWith: self)
        
        let result = XCTWaiter().wait(for: [myExpectation], timeout: time) == XCTWaiter.Result.completed
        if result {
            handler?(self)
        }
        
        return result
    }
    
    /**
     wait for element to match state and tap
     - Paramter state: expected element state
     - Paramater time: time to wait for state to match
     */
    func waitAndTap(for state: ElementState = .exists, waiting time: TimeInterval = .default) {
        guard self.wait(for: state, waiting: time) else {
            XCTFail("Element \(self.description) not found with state \(state)")
            return
        }
        
        self.tap()
    }
    
    /**
     wait and if element macthes state then tap
     - Paramater state: expected element state
     - Paramater time: time to wait for state to match
     */
    func waitAndTap(if state: ElementState = .exists, waiting time: TimeInterval = .default) {
        if self.wait(for: state, waiting: time) {
            self.tap()
        }
    }
    
    /**
     Taps in an element regardless of if the elment is hittable
     */
    func firceTap() {
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
        }
    }
    
    /**
     Replaces test text contained within a field by highlighting the exsisting text, pressing delete and typing the new text
     - Paramater: value: text to replace the existing text
     */
    func replace(text value: String) {
        self.tap(withNumberOfTaps: 3, numberOfTouches: 1)
        self.typeText(XCUIKeyboardKey.delete.rawValue)
        
        self.typeText(value)
    }
}
