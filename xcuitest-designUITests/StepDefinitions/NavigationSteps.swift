//
//  NavigationSteps.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 03/10/2025.
//

import XCTest

struct NavigationSteps {
    let app: XCUIApplication
    private var firstScreen: FirstViewScreen { FirstViewScreen(app: app) }
    private var incrementScreen: IncrementViewScreen { IncrementViewScreen(app: app) }
    private var fetchScreen: FetchViewScreen { FetchViewScreen(app: app) }
    private var navigationScreen: NavigationScreen { NavigationScreen(app: app) }

    func givenMainViewIsDisplayed() {
        XCTAssertTrue(firstScreen.isDisplayed(),   "Main view should be visible")
        firstScreen.tapMe()
    }
    
    @discardableResult
    func givenIAmOnIncrementScreen() -> Self {
        if (navigationScreen.isDisplayed()) {
            navigationScreen.navigate(to: .incrementView)
        }
        
        XCTAssertTrue(incrementScreen.isDisplayed(), "Increment screen should be visible")
        return self
    }
    
    @discardableResult
    func givenIAmOnFetchScreen() -> Self {
        if (navigationScreen.isDisplayed()) {
            navigationScreen.navigate(to: .fetchView)
        }
        
        XCTAssertTrue(fetchScreen.isDisplayed(), "Increment screen should be visible")
        return self
    }
}
