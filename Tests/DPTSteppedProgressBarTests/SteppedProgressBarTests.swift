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
} 