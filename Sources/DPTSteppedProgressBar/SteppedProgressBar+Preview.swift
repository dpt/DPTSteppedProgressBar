import SwiftUI

struct SteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
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
                palette: Palette(
                    primary: .blue,
                    active: .blue.opacity(0.8),
                    secondary: .blue.opacity(0.2)
                ),
                stepSize: CGSize(width: 16, height: 24),
                cornerRadius: 6
            )
            .previewDisplayName("Tall Rounded Rectangles")
            
            // Wide pill shapes
            SteppedProgressBar(
                currentStep: 4,
                totalSteps: 6,
                direction: .horizontal,
                palette: Palette(
                    primary: .green,
                    active: .yellow,
                    secondary: .gray.opacity(0.2)
                ),
                stepSize: CGSize(width: 32, height: 16),
                cornerRadius: 8
            )
            .previewDisplayName("Wide Pills")
            
            // Square steps
            SteppedProgressBar(
                currentStep: 2,
                totalSteps: 3,
                direction: .horizontal,
                palette: Palette(
                    primary: .purple,
                    active: .pink,
                    secondary: .purple.opacity(0.15)
                ),
                stepSize: CGSize(width: 24, height: 24),
                cornerRadius: 4
            )
            .previewDisplayName("Square Steps")
            
            // Soft rectangles
            SteppedProgressBar(
                currentStep: 3,
                totalSteps: 5,
                direction: .horizontal,
                palette: Palette(
                    primary: .black,
                    active: .blue,
                    secondary: .gray.opacity(0.2)
                ),
                stepSize: CGSize(width: 24, height: 16),
                cornerRadius: 3
            )
            .previewDisplayName("Soft Rectangles")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 