//
//  DPTSteppedProgressBar+Preview.swift
//  DPTSteppedProgressBar
//

import SwiftUI

struct DPTSteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Default style (circular)
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5
                )
                .previewDisplayName("Default Style (Circular)")

                Divider()

                // Default style with labels
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    palette: .init(
                        complete: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        incomplete: Color(red: 0.95, green: 0.95, blue: 1.0),
                        completeConnection: Color(red: 0.6, green: 0.8, blue: 1.0),
                        incompleteConnection: Color(red: 0.8, green: 0.8, blue: 0.8)
                    ),
                    steps: [
                        .init(
                            label: "Start",
                            accessibilityLabel: "Starting point",
                            accessibilityHint: "Initial setup complete"
                        ),
                        .init(
                            label: "Details",
                            accessibilityLabel: "Personal details",
                            accessibilityHint: "Enter your information"
                        ),
                        .init(
                            label: "Review the agreement",
                            accessibilityLabel: "Review details",
                            accessibilityHint: "Check your information"
                        ),
                        .init(
                            label: "Confirm",
                            accessibilityLabel: "Confirmation",
                            accessibilityHint: "Verify and proceed"
                        ),
                        .init(
                            label: "Done",
                            accessibilityLabel: "Completion",
                            accessibilityHint: "Process complete"
                        )
                    ],
                    showLabels: true,
                    labelFont: .caption.bold()
                )
                .previewDisplayName("With Labels and Accessibility")

                Divider()

                // Without connecting lines
                DPTSteppedProgressBar(
                    currentStep: 1,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Without Connecting Lines")

                Divider()

                // Thin connecting lines
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Thin Connecting Lines")

                Divider()

                // Dashed connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dashed(width: 1)
                )
                .previewDisplayName("Dashed Connecting Lines")

                Divider()

                // Dotted connecting lines
                DPTSteppedProgressBar(
                    currentStep: 4,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dotted(width: 1)
                )
                .previewDisplayName("Dotted Connecting Lines")

                Divider()

                // Vertical with custom labels
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 4,
                    direction: .vertical,
                    palette: .init(
                        complete: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        incomplete: Color(red: 0.95, green: 0.95, blue: 1.0),
                        completeConnection: Color(red: 0.6, green: 0.8, blue: 1.0),
                        incompleteConnection: Color(red: 0.85, green: 0.85, blue: 0.85)
                    ),
                    stepSize: .init(width: 16, height: 24),
                    activeStepSize: .init(width: 32, height: 24),
                    cornerRadius: 6,
                    steps: [
                        .init(label: "Lorem ipsum dolor sit amet"),
                        .init(label: "Consectetur adipiscing elit"),
                        .init(label: "Sed do eiusmod tempor"),
                        .init(label: "Incididunt ut labore et dolore magna aliqua")
                    ],
                    showLabels: true,
                    labelFont: .footnote,
                    lineStyle: .solid(width: 8)
                )
                .previewDisplayName("Vertical with Labels")

                Divider()

                // Tall rounded rectangles
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 4,
                    direction: .vertical,
                    palette: .init(
                        complete: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        incomplete: Color(red: 0.95, green: 0.95, blue: 1.0),
                        completeConnection: Color(red: 0.6, green: 0.8, blue: 1.0),
                        incompleteConnection: Color(red: 0.9, green: 0.9, blue: 0.95)
                    ),
                    stepSize: .init(width: 16, height: 24),
                    cornerRadius: 6,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Tall Rounded Rectangles")

                Divider()

                // Wide pill shapes
                DPTSteppedProgressBar(
                    currentStep: 4,
                    totalSteps: 6,
                    direction: .horizontal,
                    palette: .init(
                        complete: .green,
                        active: Color(red: 0.3, green: 0.8, blue: 0.3),
                        incomplete: Color(red: 0.95, green: 1.0, blue: 0.95),
                        completeConnection: Color(red: 0.5, green: 0.9, blue: 0.5),
                        incompleteConnection: Color(red: 0.9, green: 0.95, blue: 0.9)
                    ),
                    stepSize: .init(width: 24, height: 16),
                    activeStepSize: .init(width: 48, height: 16),
                    cornerRadius: 8
                )
                .previewDisplayName("Wide Pills")

                Divider()

                // Square steps
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 6,
                    direction: .horizontal,
                    palette: .init(
                        complete: .purple,
                        active: Color(red: 0.8, green: 0.4, blue: 0.8),
                        incomplete: Color(red: 0.95, green: 0.9, blue: 1.0),
                        completeConnection: Color(red: 0.7, green: 0.5, blue: 0.9),
                        incompleteConnection: Color(red: 0.9, green: 0.85, blue: 0.95)
                    ),
                    stepSize: .init(width: 24, height: 24),
                    activeStepSize: .init(width: 48, height: 16),
                    cornerRadius: 4
                )
                .previewDisplayName("Square Steps")

                Divider()

                // Soft rectangles
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    palette: .init(
                        complete: .black,
                        active: Color(red: 0.3, green: 0.3, blue: 0.3),
                        incomplete: Color(red: 0.95, green: 0.95, blue: 0.95),
                        completeConnection: Color(red: 0.5, green: 0.5, blue: 0.5),
                        incompleteConnection: Color(red: 0.85, green: 0.85, blue: 0.85)
                    ),
                    stepSize: .init(width: 24, height: 16),
                    spacing: 24,
                    cornerRadius: 3,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Soft Rectangles")
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
