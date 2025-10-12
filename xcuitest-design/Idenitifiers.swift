//
//  Idenitifiers.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 29/09/2025.
//

import Foundation

enum Idenitifiers {
    // String-backed enums for namespaced identifiers.
    // Access with: Idenitifiers.FirstView.helloText.value

    enum Navigation: String {
        case incrementView = "navigation.incrementView"
        case fetchView = "navigation.fetchView"

        var value: String { rawValue }
    }

    
    enum FirstView: String {
        case titleText = "First View"
        case helloText = "firstView.helloText"
        case tapMe = "firstView.tapMe"

        var value: String { rawValue }
    }

    enum IncrementView: String {
        case total = "incrementView.total"
        case increase = "incrementView.increase"
        case decrease = "incrementView.decrease"

        var value: String { rawValue }
    }
    
    enum FetchView: String {
        case reload = "FetchView.total"
        case title = "FetchView.title"
        case id = "FetchView.id"

        var value: String { rawValue }
    }
}
