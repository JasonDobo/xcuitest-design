//
//  MainViewTest.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 27/09/2025.
//

import XCTest

final class MainViewTest: BaseUITestCase {

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testFetchScreen() {
        let navigationSteps = NavigationSteps(app: app)
        navigationSteps
            .givenIAmOnFetchScreen()
    }
    
    func testFetchScreenUpdate() {
        let navigationSteps = NavigationSteps(app: app)
        navigationSteps
            .givenIAmOnFetchScreen()
    }
    
    func testIncrement() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)
        navigationSteps
            .givenIAmOnIncrementScreen()
        
        incrementSteps
            .whenITapAdd()
            .thenIShouldSee(total: "1")
            .whenITapAdd()
            .thenIShouldSee(total: "2")
            .whenITapSubtract()
            .thenIShouldSee(total: "1")
    }
    
    func testCaculation() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)
        
        navigationSteps
            .givenIAmOnIncrementScreen()
        
        incrementSteps
            .whenNumbersAreCauluated()
            .thenIShouldSeeExpectedTotal()
    }
}
