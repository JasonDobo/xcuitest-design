//
//  XCUIElement + Extensions.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 05/04/2025.
//

import Foundation
import XCTest

@MainActor
extension XCUIElement {
    
    /**
     wait for element to match the expected state and return a bool
     - Parameter state: expected element state
     - Parameter time: time to wait for state to match
     */
    @discardableResult
    func wait(for state: ElementState, waiting time: TimeInterval = .default, handler: ((XCUIElement) -> Void)? = nil) -> Bool {
        var success = false
        defer {
            if success { handler?(self) }
        }

        if state == .exists {
            success = self.waitForExistence(timeout: time)
            return success
        }

        if state == .notExists {
            success = self.waitForNonExistence(timeout: time)
            return success
        }

        let predicate = NSPredicate(format: state.rawValue)
        let expectation = XCTNSPredicateExpectation(predicate: predicate, object: self)
        success = XCTWaiter.wait(for: [expectation], timeout: time) == .completed
        return success
    }
    
    /**
     wait for element to match state and tap
     - Paramter state: expected element state
     - Parameter time: time to wait for state to match
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
     - Parameter state: expected element state
     - Parameter time: time to wait for state to match
     */
    @discardableResult
    func waitAndTap(if state: ElementState = .exists, waiting time: TimeInterval = .default) -> Bool {
        if self.wait(for: state, waiting: time) {
            self.tap()
            return true
        }
        
        return false
    }
    
    /**
     Taps in an element regardless of if the element is hittable
     */
    @discardableResult
    func forceTap() -> Bool {
        guard self.exists else {
            return false
        }
        
        if self.isHittable {
            self.tap()
        } else {
            let coordinate: XCUICoordinate = self.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5))
            coordinate.tap()
        }
        
        return true
    }
    
    /**
     Replaces test text contained within a field by highlighting the exsisting text, pressing delete and typing the new text
     - Parameter value: text to replace the existing text
     */
    func replace(text value: String) {
        self.tap(withNumberOfTaps: 3, numberOfTouches: 1)
        self.typeText(XCUIKeyboardKey.delete.rawValue)
        
        self.typeText(value)
    }
    
    /**
     Replaces text contained within a field if required by highlighting the existing text, pressing delete and typing the new text.
     - Parameter value: text to replace the existing text
     */
    func replaceIfRequired(text value: String) {
        guard let current = self.value as? String else {
            print("No value found for \(self.debugDescription)")
            return
        }

        guard current.compare(value, options: .caseInsensitive) != .orderedSame else {
            return
        }

        if self.buttons["Clear text"].exists {
            self.buttons["Clear text"].tap()
        } else {
            self.tap(withNumberOfTaps: 3, numberOfTouches: 1)
            self.typeText(XCUIKeyboardKey.delete.rawValue)
        }

        self.typeText(value)
    }
    
    /**
     Type text into a field after taping on the field
     - Parameter value: text to be typed into the field
     */
    func enter(text value: String) {
        self.waitAndTap(for: .hittable)
        self.typeText(value)
    }
    
    /**
     Updates the text within a field by deleting the current text and then typing in the new value
     - Parameter value: text to be typed into the field
     */
    func clearAndType(text value: String) {
        self.clearText()
        self.typeText(value)
    }
    
    /**
     Clears the text within a field
     */
    func clearText() {
        guard let stringValue = self.value as? String else {
            return
        }
        
        self.coordinate(withNormalizedOffset: CGVector(dx: 0.9, dy: 0.5)).tap()
        self.typeText(
            String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        )
    }
    
    func gentleSwipe(to direction: Direction) {
        let half: CGFloat = 0.5
        let adjustment: CGFloat = 0.25
        let pressDelay: TimeInterval = 0.05
        
        let lessThanHalf = half - adjustment
        let moreThanHalf = half + adjustment
        
        let centre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: half))
        let aboveCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: lessThanHalf))
        let belowCentre = self.coordinate(withNormalizedOffset: CGVector(dx: half, dy: moreThanHalf))
        let leftOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: lessThanHalf, dy: half))
        let rightOfCentre = self.coordinate(withNormalizedOffset: CGVector(dx: moreThanHalf, dy: half))
        
        switch direction {
        case .up:
            centre.press(forDuration: pressDelay, thenDragTo: aboveCentre)
        case .down:
            centre.press(forDuration: pressDelay, thenDragTo: belowCentre)
        case .left:
            centre.press(forDuration: pressDelay, thenDragTo: leftOfCentre)
        case .right:
            centre.press(forDuration: pressDelay, thenDragTo: rightOfCentre)
        }
    }
    
    func hasKeyboardFocus() -> Bool {
        (self.value(forKey: "hasKeyboardFocus") as? Bool) ?? false
    }
}

extension UInt32 {
    static let focusDelay: UInt32 = 2
}

extension CGVector {
    // Half way across the screen and 10% from top
    static let topOffset = CGVector(dx: 0.5, dy: 0.10)
    static let proMaxOffset = CGVector(dx: 0.5, dy: 0.14)
    static let plusOffset = CGVector(dx: 0.5, dy: 0.10)
    
    // Half way across the screen and 90% from top
    static let bottomOffset = CGVector(dx: 0.5, dy: 0.9)
    static let middleOffset = CGVector(dx: 0.5, dy: 0.5)
    
    // Use this offset to tap outside the sidebar in order to close it
    static let sidebarOffset = CGVector(dx: 0.75, dy: 0.5)
}

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
