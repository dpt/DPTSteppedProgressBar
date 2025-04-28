# DPTSteppedProgressBar

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2014.0+%20%7C%20macOS%2011.0+-333333.svg)](https://developer.apple.com)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A highly customisable stepped progress indicator for SwiftUI applications. Perfect for multi-step forms, onboarding flows, and process tracking interfaces.

## Features

- 📱 Native SwiftUI implementation
- 🎨 Rich colour customisation with active state highlighting
- ↔️ Horizontal and vertical orientations
- 🔲 Flexible step shapes with adjustable corner radius
- 📐 Independent width and height control
- ♿️ Comprehensive accessibility support
- 🏷️ Optional step labels with customisable styling
- ⚡️ Lightweight and performant
- 🎯 iOS 14.0+ and macOS 11.0+ compatibility

## Installation

### Swift Package Manager

Add DPTSteppedProgressBar to your project through Xcode:
1. File → Swift Packages → Add Package Dependency
2. Enter package URL: `https://github.com/dpt/DPTSteppedProgressBar`

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/dpt/DPTSteppedProgressBar", from: "1.0.0")
]
```

## Quick Start

```swift
import SwiftUI
import DPTSteppedProgressBar

struct ContentView: View {
    var body: some View {
        SteppedProgressBar(
            currentStep: 2,
            totalSteps: 5
        )
    }
}
```

## Usage Examples

### Default Style (Circular)
```swift
SteppedProgressBar(
    currentStep: 3,
    totalSteps: 5,
    direction: .horizontal
)
```

### With Labels and Accessibility
```swift
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
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
            label: "Review",
            accessibilityLabel: "Review details",
            accessibilityHint: "Check your information"
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
```

### Custom Colours with Active State
```swift
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    palette: .init(
        primary: .blue,
        active: .blue.opacity(0.8),
        secondary: .blue.opacity(0.2)
    )
)
```

### Vertical Layout with Custom Dimensions
```swift
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    direction: .vertical,
    stepSize: .init(width: 16, height: 24),
    cornerRadius: 6
)
```

## Configuration Options

| Parameter | Type | Description | Default |
|-----------|------|-------------|---------|
| `currentStep` | `Int` | Current active step (1-based index) | Required |
| `totalSteps` | `Int` | Total number of steps | Required |
| `direction` | `Direction` | Layout orientation (.horizontal/.vertical) | `.horizontal` |
| `palette` | `Palette` | Colour scheme configuration | `.init()` |
| `stepSize` | `CGSize` | Width and height of step indicators | `.init(width: 16, height: 16)` |
| `cornerRadius` | `CGFloat?` | Corner radius of step indicators | `min(width, height) / 2` |
| `stepConfigurations` | `[Step]?` | Configuration for step labels and accessibility | `nil` |
| `showLabels` | `Bool` | Whether to show step labels | `false` |
| `labelFont` | `Font` | Font for step labels | `.caption` |
| `labelSpacing` | `CGFloat` | Space between step and label | `4` |
| `lineWidth` | `CGFloat` | Width of connecting lines | `2` |
| `strokeWidth` | `CGFloat` | Width of step border strokes | `2` |

### Step Configuration

The `Step` structure allows for detailed customisation of each step:

```swift
.init(
    label: "Step 1",              // Visual label (optional)
    accessibilityLabel: "Start",  // VoiceOver label
    accessibilityHint: "Begin"    // Additional VoiceOver context
)
```
