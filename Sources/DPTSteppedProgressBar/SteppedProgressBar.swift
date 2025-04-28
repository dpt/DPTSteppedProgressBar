import SwiftUI

/// Defines the layout direction of the progress bar
public enum ProgressDirection {
    /// Arranges steps horizontally from left to right
    case horizontal
    /// Arranges steps vertically from top to bottom
    case vertical
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
///     primaryColor: .blue,
///     secondaryColor: .gray.opacity(0.3),
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
    /// The colour used for completed steps and connections
    let primaryColor: Color
    /// The colour used for incomplete steps
    let secondaryColor: Color
    /// The diameter of each step indicator
    let stepSize: CGFloat
    
    /// Creates a new stepped progress bar
    /// - Parameters:
    ///   - currentStep: The current step (1-based index)
    ///   - totalSteps: The total number of steps
    ///   - direction: The layout direction (.horizontal or .vertical)
    ///   - primaryColor: The colour for completed steps and connections
    ///   - secondaryColor: The colour for incomplete steps
    ///   - stepSize: The diameter of each step indicator
    public init(
        currentStep: Int,
        totalSteps: Int,
        direction: ProgressDirection = .horizontal,
        primaryColor: Color = .blue,
        secondaryColor: Color = .gray.opacity(0.3),
        stepSize: CGFloat = 16
    ) {
        self.currentStep = min(max(1, currentStep), totalSteps)
        self.totalSteps = totalSteps
        self.direction = direction
        self.primaryColor = primaryColor
        self.secondaryColor = secondaryColor
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
    
    /// Generates the step indicators and connecting lines
    private var progressContent: some View {
        ForEach(0..<totalSteps, id: \.self) { index in
            Circle()
                .fill(index < currentStep ? primaryColor : secondaryColor)
                .frame(width: stepSize, height: stepSize)
                .overlay(
                    Circle()
                        .strokeBorder(index < currentStep ? primaryColor : secondaryColor, lineWidth: 2)
                )
                .overlay(
                    Group {
                        if index < currentStep - 1 {
                            Rectangle()
                                .fill(primaryColor)
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
