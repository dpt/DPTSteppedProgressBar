//
//  SteppedProgressBar+Preview.swift
//  DPTSteppedProgressBar
//

import SwiftUI

struct SteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            // Default style with labels
            SteppedProgressBar(
                currentStep: 3,
                totalSteps: 5,
                direction: .horizontal,
                stepConfigurations: [
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

            // Vertical with custom labels
            SteppedProgressBar(
                currentStep: 2,
                totalSteps: 4,
                direction: .vertical,
                palette: .init(
                    primary: .blue,
                    active: .blue.opacity(0.8),
                    secondary: .blue.opacity(0.2)
                ),
                stepSize: .init(width: 16, height: 24),
                cornerRadius: 6,
                stepConfigurations: [
                    .init(label: "Q1"),
                    .init(label: "Q2"),
                    .init(label: "Q3"),
                    .init(label: "Q4")
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
                    active: .blue.opacity(0.8),
                    secondary: .blue.opacity(0.2)
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
                    active: .yellow,
                    secondary: .gray.opacity(0.2)
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
                    active: .pink,
                    secondary: .purple.opacity(0.15)
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
                    active: .blue,
                    secondary: .gray.opacity(0.2)
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
