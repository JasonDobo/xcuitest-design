//
//  IncrementFeature.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 24/10/2025.
//

import XCTest

class MathsFeature: BaseUITestCase {
    
    func testUserCanIncrementNumber() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)
        let presses = 5
        
        scenario("User can increment numbers") { step in
            step.Given("I am on the increment screen") { navigationSteps.givenIAmOnIncrementScreen() }
            step.When("I can increment numbers") { incrementSteps.incrementNumbers(total: presses) }
            step.Then("the number is \(presses)") { incrementSteps.thenIShouldSee(total: presses) }
        }
    }
    
    func testUserCanDecrementNumber() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)
        let presses = -4
        
        scenario("User can decrement numbers") { step in
            step.Given("I am on the increment screen") { navigationSteps.givenIAmOnIncrementScreen() }
            step.When("I can increment numbers") { incrementSteps.decrementNumbers(total: abs(presses) ) }
            step.Then("the number is \(presses)") { incrementSteps.thenIShouldSee(total: presses) }
        }
    }
    
    func testUserCanIncrementAndDecrementNumber() {
        let navigationSteps = NavigationSteps(app: app)
        let incrementSteps = IncrementSteps(app: app)
        let increment = 6
        let decrement = -2
        let total = increment + decrement
        
        scenario("User can increment and decrement numbers", failureMode: .stopOnFirst) { step in
            step.Given("I am on the increment screen") { navigationSteps.givenIAmOnIncrementScreen() }
            step.When("I can increment numbers") { incrementSteps.incrementNumbers(total: increment) }
            step.And("I can decrement numbers") { incrementSteps.decrementNumbers(total: abs(decrement)) }
            step.Then("the number is \(total)") { incrementSteps.thenIShouldSee(total: (total)) }
        }
    }
}
