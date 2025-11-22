//
//  Untitled.swift
//  xcuitest-design
//
//  Created by Jason Dobo on 22/11/2025.
//

import Testing
import SwiftUI
import ViewInspector
@testable import xcuitest_design

@Suite("MainView UI Tests")
@MainActor
struct MainViewTests {
    @Test("MainView displays globe image and Hello, world! text")
    func testMainViewBasics() throws {
        let view = MainView()
        let inspection = try view.inspect()
        
        // Test for Image with systemName: "globe"
        let hasGlobe = try? inspection.find(ViewType.Image.self) { image in
            (try? image.actualImage().name()) == "globe"
        }
        #expect(hasGlobe != nil, "MainView should have a globe image")
        
        // Test for Text: "Hello, world!"
        let hasHelloWorld = try? inspection.find(ViewType.Text.self) { text in
            (try? text.string()) == "Hello, world!"
        }
        #expect(hasHelloWorld != nil, "MainView should show 'Hello, world!' text")
    }

    @Test("MainView displays the Go Full Screen button")
    func testMainViewHasGoFullScreenButton() throws {
        let view = MainView()
        let inspection = try view.inspect()

        let hasGoFullScreenButton = try? inspection.find(ViewType.Button.self) { button in
            (try? button.find(ViewType.Text.self).string()) == "Go Full Screen"
        }
        #expect(hasGoFullScreenButton != nil, "MainView should have Go Full Screen button")
    }
}
