import SwiftUI

/// Defines the layout direction of the progress bar
public enum ProgressDirection {
    /// Arranges steps horizontally from left to right
    case horizontal
    /// Arranges steps vertically from top to bottom
    case vertical
}

/// Defines the colour scheme for the progress bar
public struct Palette {
    /// The colour used for completed steps and connections
    public let primary: Color
    /// The colour used for the currently active step
    public let active: Color
    /// The colour used for incomplete steps
    public let secondary: Color
    
    /// Creates a new colour palette for the progress bar
    /// - Parameters:
    ///   - primary: The colour for completed steps and connections
    ///   - active: The colour for the currently active step
    ///   - secondary: The colour for incomplete steps
    public init(
        primary: Color = .blue,
        active: Color? = nil,
        secondary: Color = .gray.opacity(0.3)
    ) {
        self.primary = primary
        self.active = active ?? primary.opacity(0.6)
        self.secondary = secondary
    }
}

/// A customisable stepped progress bar that shows progression through discrete steps
///
/// `SteppedProgressBar` is a SwiftUI view that displays a series of connected circles
/// representing steps in a process. The current progress is shown by filling in the circles
/// and connecting them with lines.
///
/// Example usage:
/// ```swift
/// SteppedProgressBar(
///     currentStep: 2,
///     totalSteps: 5,
///     direction: .horizontal,
///     palette: Palette(
///         primary: .blue,
///         active: .blue.opacity(0.6),
///         secondary: .gray.opacity(0.3)
///     ),
///     stepSize: 16
/// )
/// ```
public struct SteppedProgressBar: View {
    /// The current step (1-based index)
    let currentStep: Int
    /// The total number of steps
    let totalSteps: Int
    /// The layout direction of the progress bar
    let direction: ProgressDirection
    /// The colour palette for the progress bar
    let palette: Palette
    /// The diameter of each step indicator
    let stepSize: CGFloat
    
    /// Creates a new stepped progress bar
    /// - Parameters:
    ///   - currentStep: The current step (1-based index)
    ///   - totalSteps: The total number of steps
    ///   - direction: The layout direction (.horizontal or .vertical)
    ///   - palette: The colour palette for the progress bar
    ///   - stepSize: The diameter of each step indicator
    public init(
        currentStep: Int,
        totalSteps: Int,
        direction: ProgressDirection = .horizontal,
        palette: Palette = Palette(),
        stepSize: CGFloat = 16
    ) {
        self.currentStep = min(max(1, currentStep), totalSteps)
        self.totalSteps = totalSteps
        self.direction = direction
        self.palette = palette
        self.stepSize = stepSize
    }
    
    public var body: some View {
        Group {
            if direction == .horizontal {
                HStack(spacing: stepSize) {
                    progressContent
                }
            } else {
                VStack(spacing: stepSize) {
                    progressContent
                }
            }
        }
    }
    
    /// Determines the appropriate colour for a step based on its index
    private func colourForStep(_ index: Int) -> Color {
        if index + 1 == currentStep {
            return palette.active
        } else if index < currentStep {
            return palette.primary
        } else {
            return palette.secondary
        }
    }
    
    /// Generates the step indicators and connecting lines
    private var progressContent: some View {
        ForEach(0..<totalSteps, id: \.self) { index in
            Circle()
                .fill(colourForStep(index))
                .frame(width: stepSize, height: stepSize)
                .overlay(
                    Circle()
                        .strokeBorder(colourForStep(index), lineWidth: 2)
                )
                .overlay(
                    Group {
                        if index < currentStep - 1 {
                            Rectangle()
                                .fill(palette.primary)
                                .frame(
                                    width: (direction == .horizontal) ? stepSize : 2,
                                    height: (direction == .horizontal) ? 2 : stepSize
                                )
                                .offset(
                                    x: (direction == .horizontal) ? stepSize : 0,
                                    y: (direction == .horizontal) ? 0 : stepSize
                                )
                        }
                    }
                )
        }
    }
} 
