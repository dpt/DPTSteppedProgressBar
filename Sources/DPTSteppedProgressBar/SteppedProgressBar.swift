//
//  SteppedProgressBar.swift
//  DPTSteppedProgressBar
//

import SwiftUI

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
///     palette: .init(
///         primary: .blue,
///         active: .blue.opacity(0.6),
///         secondary: .gray.opacity(0.3)
///     ),
///     stepSize: .init(width: 16, height: 16),
///     cornerRadius: 8
/// )
/// ```
public struct SteppedProgressBar: View {
    /// Defines the layout direction of the progress bar
    public enum Direction {
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
        /// The colour used for incomplete connecting lines
        public let incompleteLine: Color

        /// Creates a new colour palette for the progress bar
        /// - Parameters:
        ///   - primary: The colour for completed steps and connections
        ///   - active: The colour for the currently active step
        ///   - secondary: The colour for incomplete steps
        ///   - incompleteLine: The colour for incomplete connecting lines
        public init(
            primary: Color = .blue,
            active: Color? = nil,
            secondary: Color = .gray.opacity(0.3),
            incompleteLine: Color? = nil
        ) {
            self.primary = primary
            self.active = active ?? primary.opacity(0.6)
            self.secondary = secondary
            self.incompleteLine = incompleteLine ?? secondary
        }
    }

    /// Configuration for step labels and accessibility
    public struct Step {
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

    /// The current step (1-based index)
    let currentStep: Int
    /// The total number of steps
    let totalSteps: Int
    /// The layout direction of the progress bar
    let direction: Direction
    /// The colour palette for the progress bar
    let palette: Palette
    /// The size of each step indicator
    let stepSize: CGSize
    /// The corner radius of the step indicators
    let cornerRadius: CGFloat
    /// Configuration for each step
    let stepConfigurations: [Step]?
    /// Whether to show labels
    let showLabels: Bool
    /// Font for the labels
    let labelFont: Font
    /// Spacing between step and label
    let labelSpacing: CGFloat
    /// The width of the joining lines
    let lineWidth: CGFloat?
    /// The width of the step border strokes
    let strokeWidth: CGFloat

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
    ///   - lineWidth: The width of the joining lines (nil for no lines)
    ///   - strokeWidth: The width of the step border strokes
    public init(
        currentStep: Int,
        totalSteps: Int,
        direction: Direction = .horizontal,
        palette: Palette = .init(),
        stepSize: CGSize = .init(width: 16, height: 16),
        cornerRadius: CGFloat? = nil,
        stepConfigurations: [Step]? = nil,
        showLabels: Bool = false,
        labelFont: Font = .caption,
        labelSpacing: CGFloat = 4,
        lineWidth: CGFloat? = 2,
        strokeWidth: CGFloat = 2
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
        self.strokeWidth = strokeWidth
    }

    public var body: some View {
        Group {
            if direction == .horizontal {
                HStack(spacing: stepSize.width) { allStepViews }
            } else {
                VStack(spacing: stepSize.height) { allStepViews }
            }
        }
        .backgroundPreferenceValue(StepBoundsKey.self) { bounds in
            if let lineWidth {
                GeometryReader { proxy in
                    ForEach(0..<totalSteps-1, id: \.self) { index in
                        if let from = bounds[index], let to = bounds[index + 1] {
                            Line(from: proxy[from][.center], to: proxy[to][.center])
                                .stroke(lineWidth: lineWidth)
                                .foregroundColor(index < currentStep - 1 ? palette.primary : palette.incompleteLine)
                        }
                    }
                }
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(overallAccessibilityLabel)
        .accessibilityValue(progressPercentage)
    }

    internal var overallAccessibilityLabel: String {
        "Progress tracker: Step \(currentStep) of \(totalSteps)"
    }

    internal var progressPercentage: String {
        let percentage = Int((Double(currentStep) / Double(totalSteps)) * 100)
        return "\(percentage)% complete"
    }

    internal func stepAccessibilityLabel(for index: Int) -> String {
        stepConfigurations?[index].accessibilityLabel ?? "Step \(index + 1)"
    }

    internal func stepAccessibilityHint(for index: Int) -> Text {
        Text(verbatim: stepConfigurations?[index].accessibilityHint ?? "")
    }

    internal func stepLabel(for index: Int) -> String? {
        stepConfigurations?[index].label
    }

    private func colourForStep(_ index: Int) -> Color {
        index + 1 == currentStep ? palette.active :
            index < currentStep ? palette.primary : palette.secondary
    }

    private func singleStepView(index: Int) -> some View {
        VStack(spacing: labelSpacing) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(.white)
                    .frame(width: stepSize.width, height: stepSize.height)
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(colourForStep(index))
                    .frame(width: stepSize.width, height: stepSize.height)
                    .overlay(
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .strokeBorder(colourForStep(index), lineWidth: strokeWidth)
                    )
                    .anchorPreference(key: StepBoundsKey.self,
                                      value: .bounds,
                                      transform: { [index: $0] })
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

    private var allStepViews: some View {
        ForEach(0..<totalSteps, id: \.self) { index in
            singleStepView(index: index)
        }
    }

}

// todo: avoid opacity for colour choices
// todo: dotty lines, etc.

private struct StepBoundsKey: PreferenceKey {
    static let defaultValue: [Int: Anchor<CGRect>] = [:]

    static func reduce(value: inout [Int : Anchor<CGRect>],
                       nextValue: () -> [Int : Anchor<CGRect>]) {
        value.merge(nextValue(),
                    uniquingKeysWith: { $1 })
    }
}

private struct Line: Shape {
    var from: CGPoint
    var to: CGPoint

    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: from)
            p.addLine(to: to)
        }
    }
}

private extension CGRect {
    subscript(unitPoint: UnitPoint) -> CGPoint {
        .init(x: minX + width * unitPoint.x, y: minY + height * unitPoint.y)
    }
}
