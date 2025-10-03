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
