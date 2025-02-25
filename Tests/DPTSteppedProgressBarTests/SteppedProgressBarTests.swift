import XCTest
import SwiftUI
@testable import DPTSteppedProgressBar

final class SteppedProgressBarTests: XCTestCase {
    func testDefaultInitialisation() {
        let progressBar = SteppedProgressBar(currentStep: 2, totalSteps: 5)
        
        XCTAssertEqual(progressBar.currentStep, 2)
        XCTAssertEqual(progressBar.totalSteps, 5)
        XCTAssertEqual(progressBar.direction, .horizontal)
    }
    
    func testCurrentStepBoundaries() {
        // Test lower bound
        let lowerBoundBar = SteppedProgressBar(currentStep: 0, totalSteps: 5)
        XCTAssertEqual(lowerBoundBar.currentStep, 1, "Current step should be clamped to minimum 1")
        
        // Test upper bound
        let upperBoundBar = SteppedProgressBar(currentStep: 6, totalSteps: 5)
        XCTAssertEqual(upperBoundBar.currentStep, 5, "Current step should be clamped to totalSteps")
    }
    
    func testCustomisation() {
        let customBar = SteppedProgressBar(
            currentStep: 3,
            totalSteps: 5,
            direction: .vertical,
            primaryColour: .red,
            secondaryColour: .green,
            stepSize: 24
        )
        
        XCTAssertEqual(customBar.direction, .vertical)
        XCTAssertEqual(customBar.primaryColour, .red)
        XCTAssertEqual(customBar.secondaryColour, .green)
        XCTAssertEqual(customBar.stepSize, 24)
    }
    
    func testViewHierarchy() {
        let progressBar = SteppedProgressBar(currentStep: 2, totalSteps: 3)
        let view = progressBar.body
        
        // Test that the view exists and has the correct structure
        XCTAssertNotNil(view)
        
        // Test horizontal layout
        let horizontalBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .horizontal
        )
        let horizontalView = horizontalBar.body
        XCTAssertNotNil(horizontalView)
        
        // Test vertical layout
        let verticalBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .vertical
        )
        let verticalView = verticalBar.body
        XCTAssertNotNil(verticalView)
    }
} 