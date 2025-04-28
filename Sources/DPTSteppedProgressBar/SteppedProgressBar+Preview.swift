//
//  SteppedProgressBar+Preview.swift
//  DPTSteppedProgressBar
//

import SwiftUI

struct SteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Default style with labels
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    palette: .init(
                        primary: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        secondary: Color(red: 0.95, green: 0.95, blue: 1.0),
                        incompleteLine: Color(red: 0.8, green: 0.8, blue: 0.8)
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
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Without Connecting Lines")

                // Thin connecting lines
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Thin Connecting Lines")

                // Dashed connecting lines
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dashed(width: 1)
                )
                .previewDisplayName("Dashed Connecting Lines")

                // Dotted connecting lines
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dotted(width: 1)
                )
                .previewDisplayName("Dotted Connecting Lines")

                // Vertical with custom labels
                SteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 4,
                    direction: .vertical,
                    palette: .init(
                        primary: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        secondary: Color(red: 0.95, green: 0.95, blue: 1.0),
                        incompleteLine: Color(red: 0.85, green: 0.85, blue: 0.85)
                    ),
                    stepSize: .init(width: 16, height: 24),
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
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Default Style (Circular)")

                // Tall rounded rectangles
                SteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 4,
                    direction: .vertical,
                    palette: .init(
                        primary: .blue,
                        active: Color(red: 0.4, green: 0.6, blue: 1.0),
                        secondary: Color(red: 0.95, green: 0.95, blue: 1.0),
                        incompleteLine: Color(red: 0.9, green: 0.9, blue: 0.95)
                    ),
                    stepSize: .init(width: 16, height: 24),
                    cornerRadius: 6
                )
                .previewDisplayName("Tall Rounded Rectangles")

                // Wide pill shapes
                SteppedProgressBar(
                    currentStep: 4,
                    totalSteps: 6,
                    direction: .horizontal,
                    palette: .init(
                        primary: .green,
                        active: Color(red: 0.3, green: 0.8, blue: 0.3),
                        secondary: Color(red: 0.95, green: 1.0, blue: 0.95),
                        incompleteLine: Color(red: 0.9, green: 0.95, blue: 0.9)
                    ),
                    stepSize: .init(width: 32, height: 16),
                    cornerRadius: 8
                )
                .previewDisplayName("Wide Pills")

                // Square steps
                SteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 3,
                    direction: .horizontal,
                    palette: .init(
                        primary: .purple,
                        active: Color(red: 0.8, green: 0.4, blue: 0.8),
                        secondary: Color(red: 0.95, green: 0.9, blue: 1.0),
                        incompleteLine: Color(red: 0.9, green: 0.85, blue: 0.95)
                    ),
                    stepSize: .init(width: 24, height: 24),
                    cornerRadius: 4
                )
                .previewDisplayName("Square Steps")

                // Soft rectangles
                SteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    palette: .init(
                        primary: .black,
                        active: Color(red: 0.3, green: 0.3, blue: 0.3),
                        secondary: Color(red: 0.95, green: 0.95, blue: 0.95),
                        incompleteLine: Color(red: 0.85, green: 0.85, blue: 0.85)
                    ),
                    stepSize: .init(width: 24, height: 16),
                    cornerRadius: 3
                )
                .previewDisplayName("Soft Rectangles")
            }
            .padding()
            .previewLayout(.sizeThatFits)
        }
    }
}
