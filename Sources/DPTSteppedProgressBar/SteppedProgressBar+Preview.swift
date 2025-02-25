import SwiftUI

struct SteppedProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 40) {
            // Horizontal progress bar
            SteppedProgressBar(
                currentStep: 3,
                totalSteps: 5,
                direction: .horizontal,
                primaryColor: .blue,
                secondaryColor: .gray.opacity(0.3),
                stepSize: 20
            )
            
            // Vertical progress bar
            SteppedProgressBar(
                currentStep: 2,
                totalSteps: 4,
                direction: .vertical,
                primaryColor: .green,
                secondaryColor: .gray.opacity(0.3),
                stepSize: 24
            )
            
            // Custom styled progress bar
            SteppedProgressBar(
                currentStep: 4,
                totalSteps: 6,
                direction: .horizontal,
                primaryColor: .purple,
                secondaryColor: .pink.opacity(0.2),
                stepSize: 16
            )
        }
        .padding()
    }
} 