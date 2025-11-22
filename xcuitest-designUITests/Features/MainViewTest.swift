//
//  MainViewTest.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 27/09/2025.
//

import XCTest

final class MainViewTest: BaseUITestCase {

    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        // This measures how long it takes to launch your application.
        measure(metrics: [XCTApplicationLaunchMetric()]) {
            XCUIApplication().launch()
        }
    }
    
    func testMainView() {
        let navigationSteps = NavigationSteps(app: app)
        scenario("User can view the first view") { step in
            step.Given("I am on the increment screen") { navigationSteps.givenMainViewIsDisplayed() }
        }
    }
    
    func testNavigateToFetchView() {
        let navigationSteps = NavigationSteps(app: app)
        let fetchSteps = FetchSteps(app: app)

        scenario("User can navigate to fetch screen") { step in
            step.When("User selects Fetch View button") { navigationSteps.givenIAmOnFetchScreen() }
            step.Then("The fetch screen is displayed") { fetchSteps.thenTheFetchViewIsDisplayed() }
        }
    }
    
    func testNavigateToIncrementView() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)

        scenario("User can navigate to fetch screen") { step in
            step.When("User selects Fetch View button") { navigationSteps.givenIAmOnIncrementScreen() }
            step.Then("The fetch screen is displayed") { incrementSteps.thenTheIncrementViewIsDisplayed() }
        }
    }
}
