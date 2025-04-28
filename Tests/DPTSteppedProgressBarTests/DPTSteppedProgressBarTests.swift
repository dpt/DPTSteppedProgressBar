//
//  DPTSteppedProgressBarTests.swift
//  DPTSteppedProgressBarTests
//

import XCTest
import SwiftUI
@testable import DPTSteppedProgressBar

final class DPTSteppedProgressBarTests: XCTestCase {
    func testDefaultInitialisation() {
        let progressBar = DPTSteppedProgressBar(currentStep: 2, totalSteps: 5)
        let defaultPalette = DPTSteppedProgressBar.Palette()

        XCTAssertEqual(progressBar.currentStep, 2)
        XCTAssertEqual(progressBar.totalSteps, 5)
        XCTAssertEqual(progressBar.direction, .horizontal)
        XCTAssertEqual(progressBar.stepSize, CGSize(width: 16, height: 16))
        XCTAssertEqual(progressBar.activeStepSize, CGSize(width: 16, height: 16))
        XCTAssertEqual(progressBar.cornerRadius, 8)
        XCTAssertEqual(progressBar.palette.complete, defaultPalette.complete)
        XCTAssertEqual(progressBar.palette.incomplete, defaultPalette.incomplete)
        XCTAssertEqual(progressBar.palette.active, defaultPalette.active)
        XCTAssertNil(progressBar.lineStyle)
        XCTAssertNil(progressBar.strokeWidth)
    }

    func testCurrentStepBoundaries() {
        // Test lower bound
        let lowerBoundBar = DPTSteppedProgressBar(currentStep: 0, totalSteps: 5)
        XCTAssertEqual(lowerBoundBar.currentStep, 1, "Current step should be clamped to minimum 1")

        // Test upper bound
        let upperBoundBar = DPTSteppedProgressBar(currentStep: 6, totalSteps: 5)
        XCTAssertEqual(upperBoundBar.currentStep, 5, "Current step should be clamped to totalSteps")
    }

    func testPaletteConfiguration() {
        // Test default palette
        let defaultPalette = DPTSteppedProgressBar.Palette()
        XCTAssertEqual(defaultPalette.complete, .blue)
        XCTAssertEqual(defaultPalette.incomplete, .gray.opacity(0.3))
        XCTAssertEqual(defaultPalette.active, .blue.opacity(0.6))
        XCTAssertEqual(defaultPalette.incompleteConnection, .gray.opacity(0.3))

        // Test custom palette with explicit active and incompleteConnection colours
        let customPalette = DPTSteppedProgressBar.Palette(
            complete: .green,
            active: .yellow,
            incomplete: .gray,
            incompleteConnection: .gray.opacity(0.5)
        )
        XCTAssertEqual(customPalette.complete, .green)
        XCTAssertEqual(customPalette.active, .yellow)
        XCTAssertEqual(customPalette.incomplete, .gray)
        XCTAssertEqual(customPalette.incompleteConnection, .gray.opacity(0.5))

        // Test custom palette with default active and incompleteConnection colours
        let derivedPalette = DPTSteppedProgressBar.Palette(
            complete: .red,
            incomplete: .gray
        )
        XCTAssertEqual(derivedPalette.complete, .red)
        XCTAssertEqual(derivedPalette.active, .red.opacity(0.6))
        XCTAssertEqual(derivedPalette.incomplete, .gray)
        XCTAssertEqual(derivedPalette.incompleteConnection, .gray)
    }

    func testStepSizeConfiguration() {
        // Test default size
        let defaultBar = DPTSteppedProgressBar(currentStep: 1, totalSteps: 2)
        XCTAssertEqual(defaultBar.stepSize, CGSize(width: 16, height: 16))
        XCTAssertEqual(defaultBar.activeStepSize, CGSize(width: 16, height: 16))

        // Test custom sizes
        let customBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 24, height: 32),
            activeStepSize: CGSize(width: 48, height: 32)
        )
        XCTAssertEqual(customBar.stepSize, CGSize(width: 24, height: 32))
        XCTAssertEqual(customBar.activeStepSize, CGSize(width: 48, height: 32))
    }

    func testCornerRadiusConfiguration() {
        let defaultBar = DPTSteppedProgressBar(currentStep: 1, totalSteps: 2)
        XCTAssertEqual(defaultBar.cornerRadius, 8)

        let customBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            cornerRadius: 4
        )
        XCTAssertEqual(customBar.cornerRadius, 4)

        let tallBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 16, height: 24)
        )
        XCTAssertEqual(tallBar.cornerRadius, 8)

        let wideBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            stepSize: CGSize(width: 32, height: 16)
        )
        XCTAssertEqual(wideBar.cornerRadius, 8)
    }

    func testDirectionConfiguration() {
        let horizontalBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .horizontal
        )
        XCTAssertEqual(horizontalBar.direction, .horizontal)

        let verticalBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            direction: .vertical
        )
        XCTAssertEqual(verticalBar.direction, .vertical)
    }

    func testViewHierarchy() {
        let progressBar = DPTSteppedProgressBar(currentStep: 2, totalSteps: 3)
        let view = progressBar.body
        XCTAssertNotNil(view)
    }

    func testStepConfigurationInitialisation() {
        let config = DPTSteppedProgressBar.Step(
            label: "Test",
            accessibilityLabel: "Test Step",
            accessibilityHint: "Test Hint"
        )

        XCTAssertEqual(config.label, "Test")
        XCTAssertEqual(config.accessibilityLabel, "Test Step")
        XCTAssertEqual(config.accessibilityHint, "Test Hint")
    }

    func testAccessibilityConfiguration() {
        let configs: [DPTSteppedProgressBar.Step] = [
            .init(
                label: "Start",
                accessibilityLabel: "Starting point",
                accessibilityHint: "Begin here"
            ),
            .init(
                label: "Middle",
                accessibilityLabel: "Midpoint",
                accessibilityHint: "Continue"
            ),
            .init(
                label: "End",
                accessibilityLabel: "Endpoint",
                accessibilityHint: "Complete"
            )
        ]

        let progressBar = DPTSteppedProgressBar(
            currentStep: 2,
            totalSteps: 3,
            steps: configs,
            showLabels: true
        )

        // Test overall accessibility
        XCTAssertEqual(progressBar.overallAccessibilityLabel, "Progress tracker: Step 2 of 3")
        XCTAssertEqual(progressBar.progressPercentage, "66% complete")

        // Test individual step accessibility
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 0), "Starting point")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 1), "Midpoint")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 2), "Endpoint")

        // Test accessibility hints
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 0), Text(verbatim: "Begin here"))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 1), Text(verbatim: "Continue"))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 2), Text(verbatim: "Complete"))
    }

    func testDefaultAccessibilityLabels() {
        let progressBar = DPTSteppedProgressBar(currentStep: 1, totalSteps: 3)

        // Test default step labels when no configuration provided
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 0), "Step 1")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 1), "Step 2")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 2), "Step 3")

        // Test default hints (should be empty text)
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 0), Text(verbatim: ""))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 1), Text(verbatim: ""))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 2), Text(verbatim: ""))

        // Test out-of-bounds indices
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: -1), "Step 0")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 3), "Step 4")
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: -1), Text(verbatim: ""))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 3), Text(verbatim: ""))
    }

    func testLabelConfiguration() {
        let configs: [DPTSteppedProgressBar.Step] = [
            .init(label: "One"),
            .init(label: "Two"),
            .init(label: "Three")
        ]

        let progressBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 3,
            steps: configs,
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
            (current: 2, total: 3, expected: "66% complete")
        ]

        for testCase in testCases {
            let progressBar = DPTSteppedProgressBar(
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

    func testStrokeWidthConfiguration() {
        let defaultBar = DPTSteppedProgressBar(currentStep: 1, totalSteps: 2)
        XCTAssertNil(defaultBar.strokeWidth)

        let customBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 2,
            strokeWidth: 4
        )
        XCTAssertEqual(customBar.strokeWidth, 4)
    }

    func testPartialStepConfiguration() {
        let configs: [DPTSteppedProgressBar.Step] = [
            .init(label: "One", accessibilityHint: "First hint"),
            .init(accessibilityLabel: "Second step"),
            .init(label: "Three", accessibilityLabel: "Third step", accessibilityHint: "Last hint")
        ]

        let progressBar = DPTSteppedProgressBar(
            currentStep: 1,
            totalSteps: 3,
            steps: configs,
            showLabels: true
        )

        // Test mixed configuration handling
        XCTAssertEqual(progressBar.stepLabel(for: 0), "One")
        XCTAssertEqual(progressBar.stepLabel(for: 1), nil)
        XCTAssertEqual(progressBar.stepLabel(for: 2), "Three")

        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 0), "Step 1")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 1), "Second step")
        XCTAssertEqual(progressBar.stepAccessibilityLabel(for: 2), "Third step")

        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 0), Text(verbatim: "First hint"))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 1), Text(verbatim: ""))
        XCTAssertEqual(progressBar.stepAccessibilityHint(for: 2), Text(verbatim: "Last hint"))
    }
}
