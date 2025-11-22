//
//  NetworkFeature.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 22/11/2025.
//

import XCTest

final class NetworkFeature: BaseUITestCase {
    
    func testFetchScreenUpdate() {
        let navigationSteps = NavigationSteps(app: app)
        let fetchSteps = FetchSteps(app: app)
        navigationSteps
            .givenIAmOnFetchScreen()
        
        fetchSteps.whenIShouldBeAbleToUpdate()
    }        
}
