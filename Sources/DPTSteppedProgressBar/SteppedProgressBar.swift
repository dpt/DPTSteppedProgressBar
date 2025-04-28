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

/// Configuration for step labels and accessibility
public struct StepConfiguration {
    /// Label displayed below/beside the step (optional)
    public let label: String?
    /// Detailed accessibility description of the step
    public let accessibilityLabel: String?
    /// Additional accessibility hint about the step's purpose
    public let accessibilityHint: String?

    public init(
        label: String? = nil,
        accessibilityLabel: String? = nil,
        accessibilityHint: String? = nil
    ) {
        self.label = label
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
    }
}

/// A customisable stepped progress bar that shows progression through discrete steps
///
/// `SteppedProgressBar` is a SwiftUI view that displays a series of connected rounded rectangles
/// representing steps in a process. The current progress is shown by filling in the steps
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
///     stepSize: CGSize(width: 16, height: 16),
///     cornerRadius: 8
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
    /// The size of each step indicator
    let stepSize: CGSize
    /// The corner radius of the step indicators
    let cornerRadius: CGFloat
    /// Configuration for each step
    let stepConfigurations: [StepConfiguration]?
    /// Whether to show labels
    let showLabels: Bool
    /// Font for the labels
    let labelFont: Font
    /// Spacing between step and label
    let labelSpacing: CGFloat
    /// The width of the joining lines
    let lineWidth: CGFloat

    /// Creates a new stepped progress bar
    /// - Parameters:
    ///   - currentStep: The current step (1-based index)
    ///   - totalSteps: The total number of steps
    ///   - direction: The layout direction (.horizontal or .vertical)
    ///   - palette: The colour palette for the progress bar
    ///   - stepSize: The size of each step indicator
    ///   - cornerRadius: The corner radius of the step indicators
    ///   - stepConfigurations: Configuration for each step
    ///   - showLabels: Whether to show labels
    ///   - labelFont: Font for the labels
    ///   - labelSpacing: Spacing between step and label
    ///   - lineWidth: The width of the joining lines
    public init(
        currentStep: Int,
        totalSteps: Int,
        direction: ProgressDirection = .horizontal,
        palette: Palette = Palette(),
        stepSize: CGSize = CGSize(width: 16, height: 16),
        cornerRadius: CGFloat? = nil,
        stepConfigurations: [StepConfiguration]? = nil,
        showLabels: Bool = false,
        labelFont: Font = .caption,
        labelSpacing: CGFloat = 4,
        lineWidth: CGFloat = 2
    ) {
        self.currentStep = min(max(1, currentStep), totalSteps)
        self.totalSteps = totalSteps
        self.direction = direction
        self.palette = palette
        self.stepSize = stepSize
        self.cornerRadius = cornerRadius ?? min(stepSize.width, stepSize.height) / 2
        self.stepConfigurations = stepConfigurations
        self.showLabels = showLabels
        self.labelFont = labelFont
        self.labelSpacing = labelSpacing
        self.lineWidth = lineWidth
    }
    
    public var body: some View {
        Group {
            if direction == .horizontal {
                HStack(spacing: stepSize.width) {
                    progressContent
                }
            } else {
                VStack(spacing: stepSize.height) {
                    progressContent
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(overallAccessibilityLabel)
        .accessibilityValue(progressPercentage)
    }
    
    private var overallAccessibilityLabel: String {
        "Progress tracker: Step \(currentStep) of \(totalSteps)"
    }
    
    private var progressPercentage: String {
        let percentage = Int((Double(currentStep) / Double(totalSteps)) * 100)
        return "\(percentage)% complete"
    }
    
    private func stepAccessibilityLabel(for index: Int) -> String {
        if let configs = stepConfigurations,
           index < configs.count,
           let label = configs[index].accessibilityLabel {
            return label
        }
        return "Step \(index + 1)"
    }
    
    private func stepAccessibilityHint(for index: Int) -> Text {
        Text(verbatim: stepConfigurations?[index].accessibilityHint ?? "")
    }
    
    private func stepLabel(for index: Int) -> String? {
        stepConfigurations?[index].label
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
            VStack(spacing: labelSpacing) {
                ZStack {
                    RoundedRectangle(cornerRadius: cornerRadius)
                        .fill(colourForStep(index))
                        .frame(width: stepSize.width, height: stepSize.height)
                        .overlay(
                            RoundedRectangle(cornerRadius: cornerRadius)
                                .strokeBorder(colourForStep(index), lineWidth: 2)
                        )
                    if index < currentStep - 1 {
                        Rectangle()
                            .fill(palette.primary)
                            .frame(
                                width: direction == .horizontal ? stepSize.width : lineWidth,
                                height: direction == .horizontal ? lineWidth : stepSize.height
                            )
                            .offset(
                                x: direction == .horizontal ? stepSize.width : 0,
                                y: direction == .horizontal ? 0 : stepSize.height
                            )
                    }
                }
                .accessibilityElement(children: .ignore)
                .accessibilityLabel(stepAccessibilityLabel(for: index))
                .accessibilityHint(stepAccessibilityHint(for: index))
                .accessibilityAddTraits(index + 1 == currentStep ? .isSelected : [])
                .accessibilityAddTraits(index < currentStep ? .isButton : [])

                if showLabels, let label = stepLabel(for: index) {
                    Text(label)
                        .font(labelFont)
                        .foregroundColor(colourForStep(index))
                }
            }
            .padding(.bottom, showLabels ? labelSpacing : 0)
        }
    }
} 
