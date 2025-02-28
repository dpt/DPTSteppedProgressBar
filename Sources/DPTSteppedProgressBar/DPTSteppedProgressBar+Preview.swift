//
//  DPTSteppedProgressBar+Preview.swift
//  DPTSteppedProgressBar
//

import SwiftUI

struct DPTSteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 40) {
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

                // Without connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Without Connecting Lines")

                // Thin connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Thin Connecting Lines")

                // Dashed connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dashed(width: 1)
                )
                .previewDisplayName("Dashed Connecting Lines")

                // Dotted connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dotted(width: 1)
                )
                .previewDisplayName("Dotted Connecting Lines")

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
                    activeStepSize: .init(width: 24, height: 24),
                    cornerRadius: 6,
                    steps: [
                        .init(label: "Lorem ipsum"),
                        .init(label: "dolor"),
                        .init(label: "sit"),
                        .init(label: "amet")
                    ],
                    showLabels: true,
                    labelFont: .footnote
                )
                .previewDisplayName("Vertical with Labels")

                // Default style (circular)
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Default Style (Circular)")

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
                    cornerRadius: 6
                )
                .previewDisplayName("Tall Rounded Rectangles")

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

                // Square steps
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 3,
                    direction: .horizontal,
                    palette: .init(
                        complete: .purple,
                        active: Color(red: 0.8, green: 0.4, blue: 0.8),
                        incomplete: Color(red: 0.95, green: 0.9, blue: 1.0),
                        completeConnection: Color(red: 0.7, green: 0.5, blue: 0.9),
                        incompleteConnection: Color(red: 0.9, green: 0.85, blue: 0.95)
                    ),
                    stepSize: .init(width: 24, height: 24),
                    cornerRadius: 4
                )
                .previewDisplayName("Square Steps")

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
                    cornerRadius: 3
                )
                .previewDisplayName("Soft Rectangles")
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
