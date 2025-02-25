import SwiftUI

struct SteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            // Default palette
            SteppedProgressBar(
                currentStep: 3,
                totalSteps: 5,
                direction: .horizontal
            )
            .previewDisplayName("Default Style")
            
            // Custom blue palette
            SteppedProgressBar(
                currentStep: 2,
                totalSteps: 4,
                direction: .vertical,
                palette: Palette(
                    primary: .blue,
                    secondary: .blue.opacity(0.2)
                ),
                stepSize: 24
            )
            .previewDisplayName("Blue Theme")
            
            // Success/progress palette
            SteppedProgressBar(
                currentStep: 4,
                totalSteps: 6,
                direction: .horizontal,
                palette: Palette(
                    primary: .green,
                    secondary: .gray.opacity(0.2)
                ),
                stepSize: 20
            )
            .previewDisplayName("Success Theme")
            
            // Brand accent palette
            SteppedProgressBar(
                currentStep: 2,
                totalSteps: 3,
                direction: .horizontal,
                palette: Palette(
                    primary: .purple,
                    secondary: .purple.opacity(0.15)
                ),
                stepSize: 16
            )
            .previewDisplayName("Brand Theme")
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
} 