//
//  DPTSteppedProgressBar.swift
//  DPTSteppedProgressBar
//

import SwiftUI

/// A customisable stepped progress bar that shows progression through discrete steps
///
/// `DPTSteppedProgressBar` is a SwiftUI view that displays a series of connected rounded rectangles
/// representing steps in a process. The current progress is shown by filling in the steps
/// and connecting them with lines.
///
/// Example usage:
/// ```swift
/// DPTSteppedProgressBar(
///     currentStep: 2,
///     totalSteps: 5,
///     direction: .horizontal,
///     palette: .init(
///         incomplete: .blue,
///         active: .blue.opacity(0.6),
///         incomplete: .gray.opacity(0.3)
///     ),
///     stepSize: .init(width: 16, height: 16),
///     cornerRadius: 8
/// )
/// ```
public struct DPTSteppedProgressBar: View {
    /// Defines the layout direction of the progress bar
    public enum Direction {
        /// Arranges steps horizontally from left to right
        case horizontal
        /// Arranges steps vertically from top to bottom
        case vertical
    }

    /// Defines the style of connecting lines
    public enum LineStyle {
        /// Solid connecting lines with specified width
        case solid(width: CGFloat)
        /// Dashed connecting lines with specified width
        case dashed(width: CGFloat)
        /// Dotted connecting lines with specified width
        case dotted(width: CGFloat)

        var width: CGFloat {
            switch self {
            case .solid(let width), .dashed(let width), .dotted(let width):
                return width
            }
        }
    }

    /// Defines the colour scheme for the progress bar
    public struct Palette {
        /// The colour used for completed steps
        public let complete: Color
        /// The colour used for the currently active step
        public let active: Color
        /// The colour used for incomplete steps
        public let incomplete: Color
        /// The colour used for completed connecting lines
        public let completeConnection: Color
        /// The colour used for incomplete connecting lines
        public let incompleteConnection: Color

        /// Creates a new colour palette for the progress bar
        /// - Parameters:
        ///   - complete: The colour for completed steps
        ///   - active: The colour for the currently active step
        ///   - incomplete: The colour for incomplete steps
        ///   - completeConnection: The colour for completed connecting lines
        ///   - incompleteConnection: The colour for incomplete connecting lines
        public init(
            complete: Color = .blue,
            active: Color? = nil,
            incomplete: Color = .gray.opacity(0.3),
            completeConnection: Color? = nil,
            incompleteConnection: Color? = nil
        ) {
            self.complete = complete
            self.active = active ?? complete.opacity(0.6)
            self.incomplete = incomplete
            self.completeConnection = completeConnection ?? complete
            self.incompleteConnection = incompleteConnection ?? incomplete
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

    @Environment(\.colorScheme) private var colorScheme

    /// Configuration for each step
    let steps: [Step]?
    /// Whether to show labels
    let showLabels: Bool
    /// Font for the labels
    let labelFont: Font
    /// Spacing between step and label
    let labelSpacing: CGFloat
    /// The style and width of the connecting lines
    let lineStyle: LineStyle?
    /// The width of the step border strokes
    let strokeWidth: CGFloat?

    /// The current step (1-based index)
    let currentStep: Int
    /// The total number of steps
    let totalSteps: Int
    /// The layout direction of the progress bar
    let direction: Direction
    /// The colour palette for the progress bar
    let palette: Palette
    /// The default size of the step indicators
    let stepSize: CGSize
    /// The size of the active step indicator
    let activeStepSize: CGSize
    /// The space between each step
    let spacing: CGFloat?
    /// The corner radius of the step indicators
    let cornerRadius: CGFloat

    /// Creates a new stepped progress bar
    /// - Parameters:
    ///   - currentStep: The current step (1-based index)
    ///   - totalSteps: The total number of steps
    ///   - direction: The layout direction (.horizontal or .vertical)
    ///   - palette: The colour palette for the progress bar
    ///   - stepSize: The default size of the step indicators
    ///   - activeStepSize: The size of the active step indicator
    ///   - spacing: Space between step indicators
    ///   - cornerRadius: The corner radius of the step indicators
    ///   - steps: Configuration for each step
    ///   - showLabels: Whether to show labels
    ///   - labelFont: Font for the labels
    ///   - labelSpacing: Spacing between step and label
    ///   - lineStyle: The style and width of the connecting lines
    ///   - strokeWidth: The width of the step border strokes
    public init(
        currentStep: Int,
        totalSteps: Int,
        direction: Direction = .horizontal,
        palette: Palette = .init(),
        stepSize: CGSize = .init(width: 16, height: 16),
        activeStepSize: CGSize? = nil,
        spacing: CGFloat? = nil,
        cornerRadius: CGFloat? = nil,
        steps: [Step]? = nil,
        showLabels: Bool = false,
        labelFont: Font = .caption,
        labelSpacing: CGFloat = 4,
        lineStyle: LineStyle? = nil,
        strokeWidth: CGFloat? = nil
    ) {
        self.currentStep = min(max(1, currentStep), totalSteps)
        self.totalSteps = totalSteps
        self.direction = direction
        self.palette = palette
        self.stepSize = stepSize
        self.activeStepSize = activeStepSize ?? stepSize
        self.spacing = spacing
        self.cornerRadius = cornerRadius ?? min(stepSize.width, stepSize.height) / 2
        self.steps = steps
        self.showLabels = showLabels
        self.labelFont = labelFont
        self.labelSpacing = labelSpacing
        self.lineStyle = lineStyle
        self.strokeWidth = strokeWidth
    }

    internal var overallAccessibilityLabel: String {
        "Progress tracker: Step \(currentStep) of \(totalSteps)"
    }

    internal var progressPercentage: String {
        let percentage = Int((Double(currentStep) / Double(totalSteps)) * 100)
        return "\(percentage)% complete"
    }

    internal func stepAccessibilityLabel(for index: Int) -> String {
        guard let steps = steps, index >= 0, index < steps.count else {
            return "Step \(index + 1)"
        }
        return steps[index].accessibilityLabel ?? "Step \(index + 1)"
    }

    internal func stepAccessibilityHint(for index: Int) -> Text {
        guard let steps = steps, index >= 0, index < steps.count else {
            return Text(verbatim: "")
        }
        return Text(verbatim: steps[index].accessibilityHint ?? "")
    }

    internal func stepLabel(for index: Int) -> String? {
        guard let steps = steps, index >= 0, index < steps.count else {
            return nil
        }
        return steps[index].label
    }

    private func colourForStep(_ index: Int) -> Color {
        switch index {
        case currentStep - 1: return palette.active
        case ..<currentStep: return palette.complete
        default: return palette.incomplete
        }
    }

    public var body: some View {
        Group {
            if direction == .horizontal {
                HStack(alignment: .top, spacing: spacing) { allStepViews }
            } else {
                VStack(alignment: .leading, spacing: spacing) { allStepViews }
            }
        }
        .backgroundPreferenceValue(StepBoundsKey.self) { bounds in
            if let lineStyle {
                connectingLines(in: bounds, lineStyle: lineStyle)
            }
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(overallAccessibilityLabel)
        .accessibilityValue(progressPercentage)
    }

    private var allStepViews: some View {
        ForEach(0..<totalSteps, id: \.self) { index in
            singleStepView(index: index)
        }
    }

    private func singleStepView(index: Int) -> some View {
        Group {
            if direction == .horizontal {
                VStack(spacing: labelSpacing) {
                    stepIndicator(index: index)
                    if showLabels, let label = stepLabel(for: index) {
                        Text(label)
                            .font(labelFont)
                            .foregroundColor(palette.complete)
                    }
                }
                .padding(.bottom, showLabels ? labelSpacing : 0)
            } else {
                HStack(spacing: labelSpacing) {
                    stepIndicator(index: index)
                    if showLabels, let label = stepLabel(for: index) {
                        Text(label)
                            .font(labelFont)
                            .foregroundColor(palette.complete)
                    }
                }
            }
        }
    }

    private func stepIndicator(index: Int) -> some View {
        let colour = colourForStep(index)
        let isCompleted = (index < currentStep)
        let isActive = (index + 1 == currentStep)
        let stepSize = (isActive) ? activeStepSize : stepSize
        return ZStack {
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(colorScheme == .dark ? .black : .white)
            RoundedRectangle(cornerRadius: cornerRadius)
                .fill(colour)
            RoundedRectangle(cornerRadius: cornerRadius)
                .strokeBorder(colour, lineWidth: strokeWidth ?? 0)
        }
        .frame(width: stepSize.width, height: stepSize.height)
        .anchorPreference(key: StepBoundsKey.self,
                          value: .bounds,
                          transform: { [index: $0] })
        .animation(.spring(response: 0.3), value: currentStep)
        .transition(.opacity.combined(with: .scale))
        .accessibilityElement(children: .ignore)
        .accessibilityLabel(stepAccessibilityLabel(for: index))
        .accessibilityHint(stepAccessibilityHint(for: index))
        .accessibilityAddTraits(isActive ? .isSelected : [])
        .accessibilityAddTraits(isCompleted ? .isButton : [])
    }

    private func connectingLines(in bounds: [Int : Anchor<CGRect>],
                                 lineStyle: LineStyle) -> some View {
        GeometryReader { proxy in
            ForEach(0..<totalSteps-1, id: \.self) { index in
                if let from = bounds[index], let to = bounds[index + 1] {
                    Line(from: proxy[from][.center], to: proxy[to][.center], style: lineStyle)
                        .stroke(lineWidth: lineStyle.width)
                        .foregroundColor(index < currentStep - 1 ? palette.completeConnection : palette.incompleteConnection)
                }
            }
        }
    }
}

/// A preference key for storing the bounds of each step.
///
/// This is used to calculate the position of the connecting lines between steps.
private struct StepBoundsKey: PreferenceKey {
    static let defaultValue: [Int: Anchor<CGRect>] = [:]

    static func reduce(value: inout [Int : Anchor<CGRect>],
                       nextValue: () -> [Int : Anchor<CGRect>]) {
        value.merge(nextValue(),
                    uniquingKeysWith: { $1 })
    }
}

/// A line that can be used to draw between two points.
private struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    var style: DPTSteppedProgressBar.LineStyle

    func path(in rect: CGRect) -> Path {
        switch style {
        case .solid(let width):
            return solidPath(width: width)
        case .dashed(let width):
            return solidPath(width: width)
                .strokedPath(StrokeStyle(lineWidth: width,
                                         lineCap: .butt,
                                         lineJoin: .miter,
                                         dash: [4, 5]))
        case .dotted(let width):
            return solidPath(width: width)
                .strokedPath(StrokeStyle(lineWidth: width,
                                         lineCap: .round,
                                         lineJoin: .round,
                                         dash: [1, 5]))
        }
    }

    private func solidPath(width: CGFloat) -> Path {
        Path { p in
            p.move(to: from)
            p.addLine(to: to)
        }
    }
}

private extension CGRect {

    /// Access a point in the rectangle based on a unit point
    /// - Parameter unitPoint: The unit point to access
    /// - Returns: The point in the rectangle
    subscript(unitPoint: UnitPoint) -> CGPoint {
        .init(x: minX + width * unitPoint.x, y: minY + height * unitPoint.y)
    }
}
