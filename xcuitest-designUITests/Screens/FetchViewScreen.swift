//
//  FetchViewScreen.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 03/10/2025.
//

import Foundation
import XCTest

struct FetchViewScreen {
    let app: XCUIApplication
    
    private var responseId: XCUIElement { app.staticTexts[Idenitifiers.FetchView.id.rawValue] }
    private var responseTitle: XCUIElement { app.staticTexts[Idenitifiers.FetchView.title.rawValue] }
    private var reloadButton: XCUIElement { app.buttons[Idenitifiers.FetchView.reload.rawValue] }
    
    func isDisplayed() -> Bool {
        reloadButton.wait(for: .enabled)
        
        return responseTitle.wait(for: .exists) && reloadButton.wait(for: .exists)
    }
    
    func reload() {
        reloadButton.waitAndTap(for: .enabled)
    }
}
