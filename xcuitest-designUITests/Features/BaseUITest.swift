//
//  BaseUITest.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 03/10/2025.
//

import Foundation
import XCTest

class BaseUITestCase: XCTestCase {
    // Each test gets its own XCUIApplication instance: better isolation and less flakiness.
    var app: XCUIApplication!

    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false

        app = XCUIApplication()
        // common args/env:
        // app.launchArguments += ["-UITestMode"]
        // app.launchEnvironment["UITEST"] = "1"

        // If you want a fresh state for every test:
        app.launch()
    }

    override func tearDownWithError() throws {
        if app.state != .notRunning {
            app.terminate()
        }
        app = nil
        try super.tearDownWithError()
    }
}

// Testable flag to access packages
// other way to find elements through stae/type or property
// placeholder value .. explore this

//    steps.forEach { step in
//        print(step)
//    }
//
//    let names = steps.map { $0.name ?? "" }
//    let thens = steps.filter { $0.type == .then }
//
//    let emailField = app.textFields.matching(NSPredicate(format: "placeholderValue == %@", "Email")).firstMatch
//    let sliderAt50 = app.sliders.matching(NSPredicate(format: "value == '50%'")).firstMatch
//
//    
