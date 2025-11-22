//
//  IncrementSteps.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 03/10/2025.
//

import XCTest

struct IncrementSteps {
    let app: XCUIApplication
    private var incrementScreen: IncrementViewScreen { IncrementViewScreen(app: app) }
    static var expectedResult: Int = 0

    @discardableResult
    func thenTheIncrementViewIsDisplayed() -> Self {
        XCTAssertTrue(incrementScreen.isDisplayed(), "Increment View is not displayed")
        return self
    }
    
    @discardableResult
    func whenNumbersAreCauluated() -> Self {
        let randomAdd = Int.random(in: 0..<6)
        for _ in 0..<randomAdd {
            incrementScreen.add()
        }
        
        let randomDecrease = Int.random(in: 0..<6)
        for _ in 0..<randomDecrease {
            incrementScreen.subtract()
        }
        
        IncrementSteps.expectedResult = randomAdd - randomDecrease
        return self
    }
    
    @discardableResult
    func thenIShouldSeeExpectedTotal() -> Self {
        incrementScreen
            .isTotalEqual(to: IncrementSteps.expectedResult)
            .back()
        
        return self
    }

    @discardableResult
    func whenITapAdd() -> Self {
        incrementScreen.add()
        
        return self
    }

    @discardableResult
    func whenITapSubtract() -> Self {
        incrementScreen.subtract()
        
        return self
    }

    @discardableResult
    func incrementNumbers(total presses: Int) -> Self {
        guard presses > 0 else { return self }
        for _ in 0..<presses {
            incrementScreen.add()
        }
        
        return self
    }
    
    @discardableResult
    func decrementNumbers(total presses: Int) -> Self {
        guard presses > 0 else { return self }
        for _ in 0..<presses {
            incrementScreen.subtract()
        }
        
        return self
    }

    @discardableResult
    func thenIShouldSee(total value: Int) -> Self {
        incrementScreen.isTotalEqual(to: value)
        
        return self
    }
}

