# Measures Converter App

A minimalist Flutter application for converting between metric and imperial units across multiple measurement categories with smart category filtering.

## Features

### Supported Conversion Categories

#### 🌍 Distance
- Miles, Kilometers, Meters, Feet, Inches, Yards, Centimeters

#### ⚖️ Weight
- Pounds, Kilograms, Ounces, Grams, Milligrams, Tons, Metric Tons

#### 🌡️ Temperature
- Fahrenheit, Celsius, Kelvin

#### 💧 Volume
- Gallons, Liters, Milliliters, Cups, Fluid Ounces, Pints, Quarts

## App Features

- **Smart Category Filtering**: When you select a "From" unit, the "To" dropdown automatically shows only compatible units from the same category
- **None Option**: Start with "None" selected - choose your units explicitly
- **Minimalist Design**: Clean interface with underlined inputs, centered labels, and subtle styling
- **Convert Button**: Click "Convert" to perform conversions on demand
- **Input Validation**: Only accepts valid numeric inputs
- **Human-readable Results**: Displays results in natural language (e.g., "100.0 meters are 328.084 feet")
- **Color-coded Interface**: Blue header, blue values, dark gray labels for visual clarity

## How to Use

1. **Enter a Value**: Type the number you want to convert
2. **Select From Unit**: Choose the unit you're converting FROM (or leave as "None")
3. **Select To Unit**: Choose the unit you're converting TO (filtered by category)
4. **Click Convert**: Press the "Convert" button (enabled only when all fields are filled)
5. **View Result**: The conversion appears below in natural language

## Running the App

### Prerequisites
- Flutter SDK installed
- An IDE with Flutter support (VS Code, Android Studio, etc.)
- For iOS/macOS builds: Xcode must be installed

### Commands

```bash
# Get dependencies
flutter pub get

# Run on connected device/emulator
flutter run

# Run on specific platform
flutter run -d chrome        # Web
flutter run -d macos          # macOS
flutter run -d android        # Android
flutter run -d ios            # iOS

# Build for release
flutter build apk             # Android
flutter build ios             # iOS
flutter build macos           # macOS
flutter build web             # Web
```

## Technical Details

- **Language**: Dart
- **Framework**: Flutter
- **UI Design**: Material Design with custom minimalist styling
- **Architecture**: Clean Architecture with SOLID principles
- **State Management**: ChangeNotifier pattern
- **Conversion Method**: Base unit conversion with category-based filtering

## Project Structure

The app follows **Clean Architecture** and **SOLID Principles**:

```
lib/
├── main.dart                           # App entry point & dependency injection
│
├── domain/                             # Business Logic Layer
│   ├── entities/                       # Business entities
│   │   ├── unit.dart                   # Unit entity with category
│   │   ├── measurement_category.dart
│   │   └── conversion_result.dart
│   ├── repositories/                   # Repository interfaces
│   │   └── conversion_repository.dart
│   └── usecases/                       # Business use cases
│       ├── convert_value_usecase.dart
│       ├── get_categories_usecase.dart
│       └── get_units_usecase.dart
│
├── data/                               # Data Layer
│   ├── converters/                     # Conversion implementations
│   │   ├── converter.dart              # Base converter interface
│   │   ├── distance_converter.dart
│   │   ├── weight_converter.dart
│   │   ├── temperature_converter.dart  # Custom logic for temperature
│   │   └── volume_converter.dart
│   └── repositories/                   # Repository implementations
│       └── conversion_repository_impl.dart
│
└── presentation/                       # Presentation Layer
    ├── pages/                          # UI pages
    │   └── conversion_page.dart        # Main conversion interface
    ├── widgets/                        # Reusable widgets
    │   ├── value_input.dart            # Value input field
    │   ├── unit_selector.dart          # Unit dropdown with filtering
    │   └── result_display.dart         # Result message display
    └── state/                          # State management
        └── conversion_state.dart       # App state with smart filtering
```

### Architecture Benefits

- **Testable**: Each layer can be tested independently
- **Maintainable**: Clear separation of concerns
- **Scalable**: Easy to add new conversion categories
- **Flexible**: Easy to swap implementations

See [ARCHITECTURE.md](ARCHITECTURE.md) for detailed architecture documentation.

## Conversion Accuracy

The app uses standard conversion factors:
- Distance: Meters as base unit
- Weight: Grams as base unit
- Temperature: Celsius as intermediate unit (custom logic)
- Volume: Liters as base unit

All conversions maintain precision up to 4 decimal places, with trailing zeros automatically removed.

## Design Philosophy

- **Minimalist UI**: Only essential elements, no clutter
- **Smart Defaults**: Start with "None" - explicit selection required
- **Intelligent Filtering**: Category-aware dropdown filtering
- **Consistent Styling**: Blue for values, dark gray for labels
- **User-Friendly**: Natural language results
