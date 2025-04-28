# DPTSteppedProgressBar

A customisable stepped progress bar component for SwiftUI applications.

## Features

- Configurable number of steps
- Customisable colours and styling
- Animated progress updates
- Support for both horizontal and vertical orientations
- iOS 14.0+ compatibility

## Installation

### Swift Package Manager

Add the following to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "your-repository-url", from: "1.0.0")
]
```

## Usage

```swift
import DPTSteppedProgressBar

struct ContentView: View {
    var body: some View {
        SteppedProgressBar(
            currentStep: 2,
            totalSteps: 5,
            direction: .horizontal
        )
    }
}
```

## Customisation

The component supports various customisation options:

- `currentStep`: Current progress step (1-based index)
- `totalSteps`: Total number of steps
- `direction`: Layout direction (.horizontal or .vertical)
- `primaryColor`: Main progress colour
- `secondaryColor`: Incomplete steps colour
- `stepSize`: Size of each step indicator

## License

MIT License. See LICENSE file for details. 