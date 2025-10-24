//
//  BaseUITest.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 03/10/2025.
//

import Foundation
import XCTest

class BaseUITestCase: XCTestCase {
    var app: XCUIApplication!

    override func setUp() {
        super.setUp()
        continueAfterFailure = false

        app = XCUIApplication()
        // app.launchArguments += ["-uiTesting"] Not needed yet, will use later
        app.launch()
    }

    override func tearDown() {
        app.terminate()
        app = nil
        super.tearDown()
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
