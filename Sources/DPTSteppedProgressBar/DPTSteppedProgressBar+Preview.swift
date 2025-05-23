//
//  DPTSteppedProgressBar+Preview.swift
//  DPTSteppedProgressBar
//
//  This file contains SwiftUI preview examples for the DPTSteppedProgressBar component.
//  It demonstrates various configurations and use cases to help developers understand
//  how to implement and style the progress bar in their applications.
//

import SwiftUI

/// An example view demonstrating interactive functionality with step navigation buttons
///
/// This example shows how to:
/// - Bind the progress bar to state
/// - Enable interactive step navigation
/// - Implement previous/next navigation controls
/// - Display the current progress
private struct InteractiveStepsExample: View {
    @State private var currentStep = 2
    let totalSteps = 4
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Interactive Example")
                .font(.headline)
            
            DPTSteppedProgressBar(
                currentStep: $currentStep,
                totalSteps: totalSteps,
                palette: .init(
                    complete: .blue,
                    active: .blue.opacity(0.8),
                    incomplete: .gray.opacity(0.3)
                ),
                steps: [
                    .init(label: "Personal Info"),
                    .init(label: "Address"),
                    .init(label: "Payment"),
                    .init(label: "Confirm")
                ],
                showLabels: true,
                isInteractive: true,
                onStepChange: { newStep in
                    print("Step changed to \(newStep)")
                }
            )
            
            // Navigation controls
            HStack {
                Button("Previous") {
                    if currentStep > 1 {
                        currentStep -= 1
                    }
                }
                .disabled(currentStep <= 1)
                .buttonStyle(.bordered)
                
                Spacer()
                
                Text("Step \(currentStep) of \(totalSteps)")
                    .font(.caption)
                
                Spacer()
                
                Button("Next") {
                    if currentStep < totalSteps {
                        currentStep += 1
                    }
                }
                .disabled(currentStep >= totalSteps)
                .buttonStyle(.bordered)
            }
            .padding(.horizontal)
        }
        .padding()
    }
}

/// SwiftUI preview provider showcasing various configurations of DPTSteppedProgressBar
///
/// This preview demonstrates:
/// - Different layout directions (horizontal/vertical)
/// - Various styling options (colors, sizes, corner radius)
/// - Line styles (solid, dashed, dotted)
/// - Label configurations and accessibility settings
/// - Different shape variations (circular, pill, rectangular)
struct DPTSteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Default style (circular) - Simplest configuration with default settings
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5
                )
                .previewDisplayName("Default Style (Circular)")

                Divider()

                // Default style with labels and accessibility - Demonstrates advanced configuration with labels and custom colors
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

                // Without connecting lines - Shows steps without any connecting lines
                DPTSteppedProgressBar(
                    currentStep: 1,
                    totalSteps: 5,
                    direction: .horizontal
                )
                .previewDisplayName("Without Connecting Lines")

                Divider()

                // Thin connecting lines - Demonstrates customizing line width with 1px solid lines
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .solid(width: 1)
                )
                .previewDisplayName("Thin Connecting Lines")

                Divider()

                // Dashed connecting lines - Shows dashed pattern for connecting lines
                DPTSteppedProgressBar(
                    currentStep: 3,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dashed(width: 1)
                )
                .previewDisplayName("Dashed Connecting Lines")

                Divider()

                // Dotted connecting lines - Shows dotted pattern for connecting lines
                DPTSteppedProgressBar(
                    currentStep: 4,
                    totalSteps: 5,
                    direction: .horizontal,
                    lineStyle: .dotted(width: 1)
                )
                .previewDisplayName("Dotted Connecting Lines")

                Divider()

                // Vertical with custom labels - Example of vertical layout with longer label text
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

                // Tall rounded rectangles - Shows taller indicators in a vertical layout
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

                // Wide pill shapes - Demonstrates wider indicators with rounded corners (pill shape)
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

                // Square steps - Shows square indicators with minimal corner radius and strokes
                DPTSteppedProgressBar(
                    currentStep: 2,
                    totalSteps: 6,
                    direction: .horizontal,
                    palette: .init(
                        complete: .purple,
                        active: Color(red: 0.8, green: 0.4, blue: 0.8),
                        incomplete: Color(red: 0.95, green: 0.9, blue: 1.0, opacity: 0.5),
                        completeConnection: Color(red: 0.7, green: 0.5, blue: 0.9),
                        incompleteConnection: Color(red: 0.9, green: 0.85, blue: 0.95)
                    ),
                    stepSize: .init(width: 24, height: 24),
                    activeStepSize: .init(width: 48, height: 16),
                    cornerRadius: 4,
                    strokeWidth: 2
                )
                .previewDisplayName("Square Steps")

                Divider()

                // Soft rectangles - Demonstrates low corner radius rectangles with custom spacing
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
            
            Divider()
                .padding(.horizontal)
            
            // Interactive binding example - Shows a fully functional interactive implementation with navigation buttons
            InteractiveStepsExample()
                .previewDisplayName("Interactive Binding Example")
            
            .previewLayout(.sizeThatFits)
        }
    }
}
