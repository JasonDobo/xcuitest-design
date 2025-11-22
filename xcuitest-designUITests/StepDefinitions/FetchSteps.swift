//
//  FetchSteps.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 09/10/2025.
//

import Foundation
import XCTest

struct FetchSteps {
    let app: XCUIApplication
    private var fetchViewScreen: FetchViewScreen { FetchViewScreen(app: app) }

    @discardableResult
    func thenTheFetchViewIsDisplayed() -> Self {
        XCTAssertTrue(fetchViewScreen.isDisplayed(), "Fetch View is not displayed")
        return self
    }
    
    @discardableResult
    func whenIShouldBeAbleToUpdate() -> Self {
        XCTAssertTrue(fetchViewScreen.isDisplayed(), "Fetch View is not displayed")
        fetchViewScreen.reload()
        XCTAssertTrue(fetchViewScreen.isDisplayed(), "Fetch View is not updated")

        return self
    }
    
}
