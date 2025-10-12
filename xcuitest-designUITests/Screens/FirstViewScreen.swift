//
//  FirstViewScreen.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 03/10/2025.
//

import Foundation
import XCTest

struct FirstViewScreen {
    let app: XCUIApplication

    private var title: XCUIElement { app.navigationBars[Idenitifiers.FirstView.titleText.rawValue] }
    private var helloWorld: XCUIElement { app.staticTexts[Idenitifiers.FirstView.helloText.rawValue] }
    private var tapMeButton: XCUIElement { app.buttons[Idenitifiers.FirstView.tapMe.rawValue] }

    func isDisplayed() -> Bool {
        title.wait(for: .exists) && helloWorld.wait(for: .exists)
    }
    
    @discardableResult
    func tapMe() -> Self {
        XCTAssertTrue(tapMeButton.waitAndTap(if: .enabled))
        XCTAssertTrue(tapMeButton.waitAndTap(if: .hittable))
        
        tapMeButton.waitAndTap(for: .exists)
        tapMeButton.waitAndTap(for: .hittable)
        tapMeButton.tap()
        tapMeButton.forceTap()

//        tapMeButton.waitAndTap(for: .notExists) fails as expected
        
        return self
    }
}
