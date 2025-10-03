//
//  IncrementViewScreen.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 29/09/2025.
//

import XCTest

struct IncrementViewScreen {
    let app: XCUIApplication

    private var numberField: XCUIElement { app.textFields[Idenitifiers.IncrementView.total.rawValue] }
    private var addButton: XCUIElement { app.buttons[Idenitifiers.IncrementView.increase.rawValue] }
    private var subtractButton: XCUIElement { app.buttons[Idenitifiers.IncrementView.decrease.rawValue] }

    func isDisplayed() -> Bool {
        addButton.wait(for: .exists) && subtractButton.wait(for: .exists)
    }
    
    @discardableResult
    func isTotalEqual(to number: String) -> Self {
        let current = numberField.value as! String
        let result = current.compare(number, options: .caseInsensitive) == .orderedSame
        
        XCTAssertTrue(result, "Number field displayed \(numberField.label) when expected \(number)")
        
        return self
    }

    @discardableResult
    func add() -> Self {
        addButton.tap()
        return self
    }

    @discardableResult
    func subtract() -> Self {
        subtractButton.tap()
        return self
    }
    
    @discardableResult
    func back() -> Self {
        app.navigationBars.buttons.firstMatch.tap()
        return self
    }
}
