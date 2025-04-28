import SwiftUI

public enum ProgressDirection {
    case horizontal
    case vertical
}

public struct SteppedProgressBar: View {
    let currentStep: Int
    let totalSteps: Int
    let direction: ProgressDirection
    let primaryColor: Color
    let secondaryColor: Color
    let stepSize: CGFloat
    
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
