# DPTSteppedProgressBar

[![Swift](https://img.shields.io/badge/Swift-5.5+-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2014.0+%20%7C%20macOS%2011.0+-333333.svg)](https://developer.apple.com)
[![Swift Package Manager](https://img.shields.io/badge/Swift_Package_Manager-compatible-brightgreen.svg)](https://swift.org/package-manager/)

A customisable stepped progress indicator for SwiftUI. Perfect for multi-step forms, onboarding flows, and process tracking.

## Features

- 📱 Native SwiftUI implementation
- 🎨 Rich colour customisation with active state highlighting
- ↔️ Horizontal and vertical layouts
- 🔲 Flexible shapes with adjustable corner radius
- ♿️ Full VoiceOver support
- 🏷️ Optional step labels
- 🎯 iOS 14.0+ and macOS 11.0+

## Installation

Add via Xcode: File → Swift Packages → Add Package Dependency
```
https://github.com/dpt/DPTSteppedProgressBar
```

Or in `Package.swift`:
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

## Examples

### Basic Usage
```swift
// Horizontal (default)
SteppedProgressBar(
    currentStep: 3,
    totalSteps: 5
)

// Vertical
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    direction: .vertical
)
```

### With Labels and Accessibility
```swift
SteppedProgressBar(
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
        )
    ],
    showLabels: true,
    labelFont: .caption.bold()
)
```

### Custom Styling
```swift
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    palette: .init(
        primary: .blue,
        active: .blue.opacity(0.8),
        secondary: .blue.opacity(0.2)
    ),
    stepSize: .init(width: 24, height: 16),
    cornerRadius: 6,
    lineStyle: .solid(width: 2),
    strokeWidth: 2
)
```

## Configuration

### Core Parameters
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `currentStep` | `Int` | Required | Current active step (1-based) |
| `totalSteps` | `Int` | Required | Total number of steps |
| `direction` | `Direction` | `.horizontal` | Layout orientation |
| `stepSize` | `CGSize` | `.init(width: 16, height: 16)` | Size of step indicators |

### Visual Styling
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `palette` | `Palette` | `.init()` | Colour scheme for steps and lines |
| `cornerRadius` | `CGFloat?` | `min(width, height) / 2` | Corner radius |
| `lineStyle` | `LineStyle` | `.solid(width: 2)` | Style and width of connecting lines |
| `strokeWidth` | `CGFloat` | `2` | Width of step borders |

### Line Styles
| Style | Parameters | Description |
|-------|------------|-------------|
| `.solid(width:)` | `width: CGFloat` | Solid connecting lines with specified width |
| `.dashed(width:)` | `width: CGFloat` | Dashed lines with specified width |
| `.dotted(width:)` | `width: CGFloat` | Dotted lines with specified width |

### Palette Properties
| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `primary` | `Color` | `.blue` | Completed steps and connections |
| `active` | `Color` | `primary.opacity(0.6)` | Currently active step |
| `secondary` | `Color` | `.gray.opacity(0.3)` | Incomplete steps |
| `incompleteLine` | `Color` | `secondary` | Incomplete connecting lines |

### Labels & Accessibility
| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `steps` | `[Step]?` | `nil` | Step labels and hints |
| `showLabels` | `Bool` | `false` | Show step labels |
| `labelFont` | `Font` | `.caption` | Label font |
| `labelSpacing` | `CGFloat` | `4` | Space between step and label |

### Palette Configuration
```swift
.init(
    primary: .blue,         // Completed steps and lines
    active: .blue.opacity(0.8), // Current step (optional)
    secondary: .gray.opacity(0.3), // Incomplete steps
    incompleteLine: .gray.opacity(0.2) // Incomplete connecting lines (optional)
)
```

The `incompleteLine` colour defaults to match `secondary` if not specified. This allows for separate styling of incomplete connecting lines.

### Examples

```swift
// Dashed connecting lines
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    lineStyle: .dashed(width: 2)
)

// Dotted connecting lines
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    lineStyle: .dotted(width: 2)
)

// Custom connecting line colours
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    palette: .init(
        primary: .blue,
        secondary: Color(red: 0.95, green: 0.95, blue: 1.0),
        incompleteLine: Color(red: 0.9, green: 0.9, blue: 1.0)
    ),
    lineStyle: .solid(width: 2)
)

// Without connecting lines
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4
)

// Thin connecting lines
SteppedProgressBar(
    currentStep: 2,
    totalSteps: 4,
    lineStyle: .solid(width: 1)
)
```

## Accessibility

- Overall progress announced (e.g. "Progress tracker: Step 2 of 5")
- Progress percentage provided (e.g. "40% complete")
- Custom labels and hints per step
- Active step marked as selected
- Completed steps marked as buttons
- Dynamic Type support for labels

## Best Practices

- Use equal width/height for circular steps
- Use larger width for pill shapes
- Consider colour contrast for accessibility
- Provide meaningful step labels and hints
- Test with VoiceOver enabled

## Contributing

Contributions welcome! See [Contributing Guidelines](CONTRIBUTING.md).

## Licence

MIT. See [LICENSE](LICENSE).
