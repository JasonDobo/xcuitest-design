//
//  ScenarioBuilder.swift
//  xcuitest-designUITests
//
//  Created by Jason Dobo on 09/10/2025.
//

import Foundation
import XCTest

public enum StepType: String {
    case given = "GIVEN"
    case when = "WHEN"
    case then = "THEN"
    case but = "BUT"
    case and = "AND"
}

public struct Step {
    public let type: StepType
    public let name: String?
    public let action: @MainActor () throws -> Void
}

public enum FailureMode {
    case stopOnFirst
    case continueAll
}

public struct ScenarioResult {
    public let title: String?
    public let steps: [Step]
    public let failedStepIndex: Int?
    public let error: Error?
    public let duration: TimeInterval
}

public final class ScenarioBuilder {
    let title: String?
    private let testCase: XCTestCase
    private var steps: [Step] = []
    
    init(title: String?, testCase: XCTestCase) {
        self.title = title
        self.testCase = testCase
    }
    
    // MARK: Step Builders
    
    public func Given(_ name: String? = nil, _ action: @escaping @MainActor () throws -> Void) {
        steps.append (Step(type: .given, name: name, action: action))
    }
    
    public func When(_ name: String? = nil, _ action: @escaping @MainActor () throws -> Void) {
        steps.append (Step(type: .when, name: name, action: action))
    }
    
    public func Then(_ name: String? = nil, _ action: @escaping @MainActor () throws -> Void) {
        steps.append (Step(type: .then, name: name, action: action))
    }
    
    public func But(_ name: String? = nil, _ action: @escaping @MainActor () throws -> Void) {
        steps.append (Step(type: .but, name: name, action: action))
    }
    
    public func And(_ name: String? = nil, _ action: @escaping @MainActor () throws -> Void) {
        steps.append (Step(type: .and, name: name, action: action))
    }
    
    // MARK: Run
    @discardableResult
    public func run(
        failureMode: FailureMode = .stopOnFirst,
        reportToXCTest: Bool = true,
        logger: (String) -> Void = { print($0) }
    ) -> ScenarioResult {
        let start = Date()
        if let t = title, !t.isEmpty { logger("Scenario: \(t)") } else { logger("Scenario") }
        
        var firstFailureIndex: Int? = nil
        var firstError: Error? = nil
        
        for (idx, step) in steps.enumerated() {
            let label = step.name.map { "\(step.type.rawValue.capitalized): \($0)" } ?? "\(step.type.rawValue.capitalized)"
            logger(label)
            
            do {
                if Thread.isMainThread {
                    try MainActor.assumeIsolated {
                        try step.action()
                    }
                } else {
                    var thrownError: Error?
                    DispatchQueue.main.sync {
                        do {
                            try MainActor.assumeIsolated {
                                try step.action()
                            }
                        } catch {
                            thrownError = error
                        }
                    }
                    if let e = thrownError {
                        throw e
                    }
                }
            } catch {
                // Record the first failure if we haven't yet
                if firstFailureIndex == nil {
                    firstFailureIndex = idx
                    firstError = error
                }
                
                logger("Failed at step #\(idx + 1): \(step.type.rawValue.capitalized)\(step.name.map { ": \($0)" } ?? "")")
                
                if reportToXCTest {
                    // Show nicely in Xcode's Test Report
                    testCase.record(
                        XCTIssue(
                            type: .assertionFailure,
                            compactDescription: "Scenario\(title.map { " \"\($0)\"" } ?? "") failed at step #\(idx + 1): \(step.type.rawValue.capitalized)\(step.name.map { ": \($0)" } ?? "")",
                            detailedDescription: String(describing: error)
                        )
                    )
                }
                
                if failureMode == .stopOnFirst {
                    let duration = Date().timeIntervalSince(start)
                    return ScenarioResult(
                        title: title,
                        steps: steps,
                        failedStepIndex: idx,
                        error: error,
                        duration: duration
                    )
                } else {
                    // continueAll: keep going and collect further failures (we already recorded the first)
                    continue
                }
            }
        }
            
        let duration = Date().timeIntervalSince(start)
        if let firstIdx = firstFailureIndex {
            logger("Failed (continueAll) — first failure at step #\(firstIdx + 1) in \(String(format: "%.2f", duration * 1_000))ms")
        } else {
            logger("Passed in \(String(format: "%.2f", duration * 1_000))ms")
        }
        
        return ScenarioResult(title: title, steps: steps, failedStepIndex: firstFailureIndex, error: firstError, duration: duration)
    }
}
// MARK: - XCTestCase convenience
extension XCTestCase {
    
    @discardableResult
    func scenario(
        _ title: String,
        failureMode: FailureMode = .stopOnFirst,
        reportToXCTest: Bool = true,
        logger: (String) -> Void = { print($0) },
        _ build: (ScenarioBuilder) -> Void
    ) -> ScenarioResult {
        let builder  = ScenarioBuilder(title: title, testCase: self)
        build(builder)
        return builder.run(
            failureMode: failureMode,
            reportToXCTest: reportToXCTest,
            logger: logger
        )
    }
}

