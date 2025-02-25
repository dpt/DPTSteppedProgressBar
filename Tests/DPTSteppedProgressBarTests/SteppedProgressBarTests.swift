import XCTest
import SwiftUI
@testable import DPTSteppedProgressBar

final class SteppedProgressBarTests: XCTestCase {
    func testDefaultInitialisation() {
        let progressBar = SteppedProgressBar(currentStep: 2, totalSteps: 5)
        let defaultPalette = Palette()
        
        XCTAssertEqual(progressBar.currentStep, 2)
        XCTAssertEqual(progressBar.totalSteps, 5)
        XCTAssertEqual(progressBar.direction, .horizontal)
        XCTAssertEqual(progressBar.stepSize, CGSize(width: 16, height: 16))
        XCTAssertEqual(progressBar.cornerRadius, 8) // min(16, 16) / 2
        XCTAssertEqual(progressBar.palette.primary, defaultPalette.primary)
        XCTAssertEqual(progressBar.palette.secondary, defaultPalette.secondary)
        XCTAssertEqual(progressBar.palette.active, defaultPalette.active)
    }
    
    func testCurrentStepBoundaries() {
        // Test lower bound
        let lowerBoundBar = SteppedProgressBar(currentStep: 0, totalSteps: 5)
        XCTAssertEqual(lowerBoundBar.currentStep, 1, "Current step should be clamped to minimum 1")
        
        // Test upper bound
        let upperBoundBar = SteppedProgressBar(currentStep: 6, totalSteps: 5)
        XCTAssertEqual(upperBoundBar.currentStep, 5, "Current step should be clamped to totalSteps")
    }
    
    func testPaletteConfiguration() {
        // Test default palette
        let defaultPalette = Palette()
        XCTAssertEqual(defaultPalette.primary, .blue)
        XCTAssertEqual(defaultPalette.secondary, .gray.opacity(0.3))
        XCTAssertEqual(defaultPalette.active, .blue.opacity(0.6))
        
        // Test custom palette with explicit active colour
        let customPalette = Palette(
            primary: .green,
            active: .yellow,
            secondary: .gray
        )
        XCTAssertEqual(customPalette.primary, .green)
        XCTAssertEqual(customPalette.active, .yellow)
        XCTAssertEqual(customPalette.secondary, .gray)
        
        // Test custom palette with default active colour
        let derivedActivePalette = Palette(
            primary: .red,
            secondary: .gray
        )
        XCTAssertEqual(derivedActivePalette.primary, .red)
        XCTAssertEqual(derivedActivePalette.active, .red.opacity(0.6))
        XCTAssertEqual(derivedActivePalette.secondary, .gray)
    }
    
    func testStepSizeConfiguration() {
        // Test default size
        let defaultBar = SteppedProgressBar(currentStep: 1, totalSteps: 2)
        XCTAssertEqual(defaultBar.stepSize, CGSize(width: 16, height: 16))
        
        // Test custom size
        let customBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 24, height: 32)
        )
        XCTAssertEqual(customBar.stepSize, CGSize(width: 24, height: 32))
    }
    
    func testCornerRadiusConfiguration() {
        // Test default corner radius (circular)
        let defaultBar = SteppedProgressBar(currentStep: 1, totalSteps: 2)
        XCTAssertEqual(defaultBar.cornerRadius, 8) // min(16, 16) / 2
        
        // Test custom corner radius
        let customBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            cornerRadius: 4
        )
        XCTAssertEqual(customBar.cornerRadius, 4)
        
        // Test default corner radius with custom size
        let tallBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 16, height: 24)
        )
        XCTAssertEqual(tallBar.cornerRadius, 8) // min(16, 24) / 2
        
        // Test default corner radius with wide size
        let wideBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 32, height: 16)
        )
        XCTAssertEqual(wideBar.cornerRadius, 8) // min(32, 16) / 2
    }
    
    func testDirectionConfiguration() {
        // Test horizontal layout
        let horizontalBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .horizontal
        )
        XCTAssertEqual(horizontalBar.direction, .horizontal)
        
        // Test vertical layout
        let verticalBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .vertical
        )
        XCTAssertEqual(verticalBar.direction, .vertical)
    }
    
    func testViewHierarchy() {
        let progressBar = SteppedProgressBar(currentStep: 2, totalSteps: 3)
        let view = progressBar.body
        XCTAssertNotNil(view)
    }
    
    func testStepConfigurationInitialisation() {
        let config = StepConfiguration(
            label: "Test",
            accessibilityLabel: "Test Step",
            accessibilityHint: "Test Hint"
        )
        
        XCTAssertEqual(config.label, "Test")
        XCTAssertEqual(config.accessibilityLabel, "Test Step")
        XCTAssertEqual(config.accessibilityHint, "Test Hint")
    }
    
    func testAccessibilityConfiguration() {
        let configs = [
            StepConfiguration(
                label: "Start",
                accessibilityLabel: "Starting point",
                accessibilityHint: "Begin here"
            ),
            StepConfiguration(
                label: "Middle",
                accessibilityLabel: "Midpoint",
                accessibilityHint: "Continue"
            ),
            StepConfiguration(
                label: "End",
                accessibilityLabel: "Endpoint",
                accessibilityHint: "Complete"
            )
        ]
        
        let progressBar = SteppedProgressBar(
            currentStep: 2,
            totalSteps: 3,
            stepConfigurations: configs,
            showLabels: true
        )
        
        // Test overall accessibility
        XCTAssertEqual(progressBar.overallAccessibilityLabel, "Progress tracker: Step 2 of 3")
        XCTAssertEqual(progressBar.progressPercentage, "67% complete")
        
        // Test individual step accessibility
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 0), "Starting point")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 1), "Midpoint")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 2), "Endpoint")
        
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 0), "Begin here")
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 1), "Continue")
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 2), "Complete")
    }
    
    func testDefaultAccessibilityLabels() {
        let progressBar = SteppedProgressBar(currentStep: 1, totalSteps: 3)
        
        // Test default step labels when no configuration provided
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 0), "Step 1")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 1), "Step 2")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 2), "Step 3")
        
        // Test default hints (should be nil)
        XCTAssertNil(progressBar.stepAccessibilityHint(for: 0))
        XCTAssertNil(progressBar.stepAccessibilityHint(for: 1))
        XCTAssertNil(progressBar.stepAccessibilityHint(for: 2))
    }
    
    func testLabelConfiguration() {
        let configs = [
            StepConfiguration(label: "One"),
            StepConfiguration(label: "Two"),
            StepConfiguration(label: "Three")
        ]
        
        let progressBar = SteppedProgressBar(
            currentStep: 1,
            totalSteps: 3,
            stepConfigurations: configs,
            showLabels: true,
            labelFont: .title,
            labelSpacing: 8
        )
        
        // Test label retrieval
        XCTAssertEqual(progressBar.stepLabel(for: 0), "One")
        XCTAssertEqual(progressBar.stepLabel(for: 1), "Two")
        XCTAssertEqual(progressBar.stepLabel(for: 2), "Three")
        
        // Test label configuration
        XCTAssertEqual(progressBar.labelFont, .title)
        XCTAssertEqual(progressBar.labelSpacing, 8)
        XCTAssertTrue(progressBar.showLabels)
    }
    
    func testProgressPercentageCalculation() {
        let testCases = [
            (current: 1, total: 4, expected: "25% complete"),
            (current: 2, total: 4, expected: "50% complete"),
            (current: 3, total: 4, expected: "75% complete"),
            (current: 4, total: 4, expected: "100% complete"),
            (current: 1, total: 3, expected: "33% complete"),
            (current: 2, total: 3, expected: "67% complete"),
            (current: 3, total: 3, expected: "100% complete")
        ]
        
        for testCase in testCases {
            let progressBar = SteppedProgressBar(
                currentStep: testCase.current,
                totalSteps: testCase.total
            )
            XCTAssertEqual(
                progressBar.progressPercentage,
                testCase.expected,
                "Failed for step \(testCase.current) of \(testCase.total)"
            )
        }
    }
} 