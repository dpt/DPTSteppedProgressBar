# DPTSteppedProgressBar

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2015.0+%20%7C%20macOS%2011.0+-333333.svg)](https://developer.apple.com)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A customisable stepped progress indicator for SwiftUI. Perfect for multi-step forms, onboarding flows, and process tracking.

![DPTSteppedProgressBar Demo](https://via.placeholder.com/800x200?text=DPTSteppedProgressBar+Examples)

## Contents

- [Features](#features)
- [Requirements](#requirements)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Usage Examples](#usage-examples)
- [Configuration Reference](#configuration-reference)
- [Accessibility](#accessibility)
- [Best Practices](#best-practices)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

## Features

- 📱 Native SwiftUI implementation
- 🎨 Rich colour customisation with active state highlighting
- ↔️ Horizontal and vertical layouts
- 🔲 Flexible shapes with adjustable corner radius
- ♿️ Full VoiceOver support
- 🏷️ Optional step labels
- 🔄 Two-way binding support for interactive steps

## Requirements

- iOS 15.0+ / macOS 11.0+
- Swift 5.5+
- Xcode 13.0+

## Installation

### Swift Package Manager

#### In Xcode:

1. Select File → Add Packages...
2. Enter package URL: `https://github.com/dpt/DPTSteppedProgressBar`
3. Select "Up to Next Major Version" with "1.0.0"

#### In Package.swift:

```swift
dependencies: [
    .package(url: "https://github.com/dpt/DPTSteppedProgressBar", from: "1.0.0")
]
```

## Quick Start

### Basic Implementation

```swift
import SwiftUI
import DPTSteppedProgressBar

struct ContentView: View {
    var body: some View {
        DPTSteppedProgressBar(
            currentStep: 2,
            totalSteps: 5
        )
    }
}
```

### With Interactive Binding

```swift
import SwiftUI
import DPTSteppedProgressBar

struct ContentView: View {
    @State private var currentStep = 2

    var body: some View {
        VStack {
            DPTSteppedProgressBar(
                currentStep: $currentStep,
                totalSteps: 5,
                isInteractive: true
            )

            HStack {
                Button("Previous") {
                    if currentStep > 1 {
                        currentStep -= 1
                    }
                }
                .disabled(currentStep <= 1)
                .buttonStyle(.bordered)

                Spacer()

                Text("Step \(currentStep) of 5")
                    .font(.caption)

                Spacer()

                Button("Next") {
                    if currentStep < 5 {
                        currentStep += 1
                    }
                }
                .disabled(currentStep >= 5)
                .buttonStyle(.bordered)
            }
            .padding()
        }
    }
}
```

## Usage Examples

### Basic Layouts

```swift
// Horizontal layout (default)
DPTSteppedProgressBar(
    currentStep: 3,
    totalSteps: 5
)

// Vertical layout
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    direction: .vertical
)
```

### With Labels and Accessibility

```swift
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
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
            label: "Review",
            accessibilityLabel: "Review information",
            accessibilityHint: "Check your details"
        ),
        .init(
            label: "Submit",
            accessibilityLabel: "Submit application",
            accessibilityHint: "Send your information"
        )
    ],
    showLabels: true,
    labelFont: .caption.bold()
)
```

### Custom Styling

```swift
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    palette: .init(
        complete: .blue,
        active: .blue.opacity(0.8),
        incomplete: .blue.opacity(0.2)
    ),
    stepSize: .init(width: 24, height: 16),
    activeStepSize: .init(width: 48, height: 16),
    spacing: 16,
    cornerRadius: 6,
    lineStyle: .solid(width: 2),
    strokeWidth: 2
)
```

### Line Style Variations

```swift
// Solid connecting lines (default)
DPTSteppedProgressBar(
    currentStep: 2, 
    totalSteps: 4,
    lineStyle: .solid(width: 2)
)

// Dashed connecting lines
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    lineStyle: .dashed(width: 2)
)

// Dotted connecting lines
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    lineStyle: .dotted(width: 2)
)

// No connecting lines
DPTSteppedProgressBar(
    currentStep: 2,
    totalSteps: 4
)
```

### Interactive Steps with Binding

```swift
@State private var currentStep = 2

DPTSteppedProgressBar(
    currentStep: $currentStep,
    totalSteps: 4,
    isInteractive: true,
    onStepChange: { newStep in
        print("Step changed to \(newStep)")
    }
)
```

## Configuration Reference

### Core Parameters

| Parameter        | Type        | Default                        | Description                     |
|------------------|-------------|--------------------------------|---------------------------------|
| `currentStep`    | `Int`       | Required                       | Current active step (1-based)   |
| `totalSteps`     | `Int`       | Required                       | Total number of steps           |
| `direction`      | `Direction` | `.horizontal`                  | Layout orientation              |
| `stepSize`       | `CGSize`    | `.init(width: 16, height: 16)` | Default size of step indicators |
| `activeStepSize` | `CGSize`    | `stepSize`                     | Size of active step indicator   |
| `spacing`        | `CGFloat`   | nil                            | Space between step indicators   |

### Visual Styling

| Parameter       | Type        | Default                  | Description                               |
|-----------------|-------------|--------------------------|-------------------------------------------|
| `palette`       | `Palette`   | `.init()`                | Colour scheme for steps and lines         |
| `cornerRadius`  | `CGFloat?`  | `min(width, height) / 2` | Corner radius                             |
| `lineStyle`     | `LineStyle` | `.solid(width: 2)`       | Style of connecting lines (optional)      |
| `strokeWidth`   | `CGFloat`   | `nil`                    | Width of step borders (optional)          |
| `isInteractive` | `Bool`      | `false`                  | Whether steps can be tapped to navigate   |

### Line Styles

| Style             | Parameters       | Description                                 |
|-------------------|------------------|---------------------------------------------|
| `.solid(width:)`  | `width: CGFloat` | Solid connecting lines with specified width |
| `.dashed(width:)` | `width: CGFloat` | Dashed lines with specified width           |
| `.dotted(width:)` | `width: CGFloat` | Dotted lines with specified width           |

### Palette Properties

| Property               | Type    | Default                 | Description                            |
|------------------------|---------|-------------------------|----------------------------------------|
| `complete`             | `Color` | `.blue`                 | Completed steps and connections        |
| `active`               | `Color` | `complete.opacity(0.6)` | Currently active step                  |
| `incomplete`           | `Color` | `.gray.opacity(0.3)`    | Incomplete steps                       |
| `completeConnection`   | `Color` | `complete`              | Complete connecting lines              |
| `incompleteConnection` | `Color` | `incomplete`            | Incomplete connecting lines            |

### Labels & Accessibility

| Parameter      | Type               | Default    | Description                  |
|----------------|-------------------|------------|------------------------------|
| `steps`        | `[Step]?`         | `nil`      | Step labels and hints        |
| `showLabels`   | `Bool`            | `false`    | Show step labels             |
| `labelFont`    | `Font`            | `.caption` | Label font                   |
| `labelSpacing` | `CGFloat`         | `4`        | Space between step and label |
| `onStepChange` | `((Int) -> Void)?`| `nil`      | Callback when step changes   |

### Palette Configuration Example

```swift
.init(
    complete: .blue,                  // Completed steps and connections
    active: .blue.opacity(0.8),       // Currently active step
    incomplete: .gray.opacity(0.3),   // Incomplete steps
    completeConnection: .blue,        // Complete connecting lines
    incompleteConnection: .gray.opacity(0.2) // Incomplete connecting lines
)
```

> **Note:** The `incompleteConnection` colour defaults to match `incomplete` if not specified. This allows for separate styling of incomplete connecting lines.

## Accessibility

DPTSteppedProgressBar is designed with accessibility in mind:

- Overall progress announced (e.g. "Progress tracker: Step 2 of 5")
- Progress percentage provided (e.g. "40% complete")
- Custom labels and hints per step
- Active step marked as selected
- Completed steps marked as buttons
- Dynamic Type support for labels

## Best Practices

For optimal use of the stepped progress bar:

- Use equal width/height for circular steps
- Use larger width for pill-shaped indicators
- Consider colour contrast for accessibility
- Provide meaningful step labels and hints
- Test with VoiceOver enabled
- Use binding for interactive steps
- Keep total steps between 2-7 for best user experience

## Troubleshooting

### Step Indicators Not Showing

Ensure you've set reasonable values for `stepSize` and that the container view has sufficient space.

### Interactive Steps Not Working

Verify that:
1. You're using a binding (e.g., `$currentStep`) 
2. `isInteractive` is set to `true`
3. Your handler for `onStepChange` is properly implemented

### Custom Colors Not Applied

Check that you're not overriding the palette colors elsewhere in your view hierarchy. Try using `.colorScheme(.light)` or `.colorScheme(.dark)` to verify behavior in different appearances.

## Contributing

Contributions are welcome! Please see [Contributing Guidelines](CONTRIBUTING.md) for more details.

## License

DPTSteppedProgressBar is available under the MIT license. See the [LICENSE](LICENSE) file for more info.