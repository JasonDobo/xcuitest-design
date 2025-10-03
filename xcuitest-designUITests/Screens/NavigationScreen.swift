//
//  NavigationScreen.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 03/10/2025.
//

import Foundation
import XCTest

enum Navigation {
    case incrementView
    case fetchView
}

struct NavigationScreen {
    let app: XCUIApplication

    private var incrementView: XCUIElement { app.buttons[Idenitifiers.Navigation.incrementView.rawValue] }
    private var fetchView: XCUIElement { app.buttons[Idenitifiers.Navigation.fetchView.rawValue] }

    func isDisplayed() -> Bool {
        incrementView.wait(for: .exists) && fetchView.wait(for: .exists)
    }
    
    @discardableResult
    func navigate(to navigation: Navigation) -> Self {
        switch navigation {
        case .incrementView: incrementView.tap()
        case .fetchView: fetchView.tap()
        }
        
        return self
    }
}
