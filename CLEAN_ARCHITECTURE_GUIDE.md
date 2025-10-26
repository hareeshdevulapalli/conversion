# Clean Architecture Implementation Guide

## 🏛️ Architecture Overview

This Flutter app implements **Clean Architecture** with three distinct layers, following the **Dependency Rule**: dependencies only point inward.

```
┌─────────────────────────────────────────────────┐
│         PRESENTATION LAYER (UI)                 │
│  • Pages, Widgets, State Management             │
│  • Depends on: Domain                           │
└─────────────┬───────────────────────────────────┘
              │
              ↓ depends on
┌─────────────────────────────────────────────────┐
│         DOMAIN LAYER (Business Logic)           │
│  • Entities, Use Cases, Repository Interfaces   │
│  • Depends on: Nothing (Pure Dart)              │
└─────────────↑───────────────────────────────────┘
              │
              │ implements
┌─────────────┴───────────────────────────────────┐
│         DATA LAYER (Implementation)             │
│  • Repositories, Converters, Data Sources       │
│  • Depends on: Domain                           │
└─────────────────────────────────────────────────┘
```

---

## 📁 Layer Breakdown

### 1️⃣ Domain Layer (Core Business Logic)

**Location:** `lib/domain/`

**Purpose:** Contains business entities, rules, and contracts. No dependencies on external frameworks.

#### Entities (`domain/entities/`)
Business objects that represent core concepts:

- **`unit.dart`**: Represents a unit of measurement
  ```dart
  class Unit {
    final String name;
    final String symbol;
    final double conversionFactor;
  }
  ```

- **`measurement_category.dart`**: Represents a category (Distance, Weight, etc.)
  ```dart
  class MeasurementCategory {
    final String name;
    final String description;
  }
  ```

- **`conversion_result.dart`**: Represents the result of a conversion
  ```dart
  class ConversionResult {
    final double inputValue;
    final Unit fromUnit;
    final double outputValue;
    final Unit toUnit;
  }
  ```

#### Repository Interfaces (`domain/repositories/`)
Defines contracts without implementation:

- **`conversion_repository.dart`**: Interface for data operations
  ```dart
  abstract class ConversionRepository {
    List<MeasurementCategory> getCategories();
    List<Unit> getUnitsForCategory(String categoryName);
    ConversionResult convert(...);
  }
  ```

#### Use Cases (`domain/usecases/`)
Single-purpose business operations:

- **`get_categories_usecase.dart`**: Get all available categories
- **`get_units_usecase.dart`**: Get units for a category
- **`convert_value_usecase.dart`**: Perform conversion

```dart
class ConvertValueUseCase {
  final ConversionRepository repository;
  
  ConversionResult execute({...}) {
    return repository.convert(...);
  }
}
```

---

### 2️⃣ Data Layer (Implementation)

**Location:** `lib/data/`

**Purpose:** Implements domain interfaces with concrete logic.

#### Converters (`data/converters/`)
Implements conversion algorithms:

- **`converter.dart`**: Abstract base converter
  ```dart
  abstract class Converter {
    Unit get baseUnit;
    List<Unit> get availableUnits;
    double convert(double value, Unit from, Unit to);
  }
  ```

- **`distance_converter.dart`**: Distance conversions (meters as base)
- **`weight_converter.dart`**: Weight conversions (grams as base)
- **`temperature_converter.dart`**: Temperature conversions (Celsius as base)
- **`volume_converter.dart`**: Volume conversions (liters as base)

#### Repository Implementation (`data/repositories/`)

- **`conversion_repository_impl.dart`**: Implements ConversionRepository
  ```dart
  class ConversionRepositoryImpl implements ConversionRepository {
    final Map<String, Converter> _converters = {
      'Distance': DistanceConverter(),
      'Weight': WeightConverter(),
      // ...
    };
    
    @override
    ConversionResult convert(...) {
      final converter = _converters[categoryName]!;
      return converter.convert(...);
    }
  }
  ```

---

### 3️⃣ Presentation Layer (UI)

**Location:** `lib/presentation/`

**Purpose:** Displays data and handles user interaction.

#### State Management (`presentation/state/`)

- **`conversion_state.dart`**: Manages app state using ChangeNotifier
  ```dart
  class ConversionState extends ChangeNotifier {
    final GetCategoriesUseCase getCategoriesUseCase;
    final GetUnitsUseCase getUnitsUseCase;
    final ConvertValueUseCase convertValueUseCase;
    
    void setInputValue(String value) {
      _inputValue = value;
      _performConversion();
      notifyListeners();  // Updates UI
    }
  }
  ```

#### Pages (`presentation/pages/`)

- **`conversion_page.dart`**: Main page that coordinates widgets
  ```dart
  class ConversionPage extends StatelessWidget {
    final ConversionState state;
    
    @override
    Widget build(BuildContext context) {
      return ListenableBuilder(
        listenable: state,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                CategorySelector(...),
                ValueInput(...),
                UnitSelector(...),
                ResultDisplay(...),
              ],
            ),
          );
        },
      );
    }
  }
  ```

#### Widgets (`presentation/widgets/`)
Reusable, focused UI components:

- **`category_selector.dart`**: Dropdown for selecting category
- **`value_input.dart`**: Text field for entering value
- **`unit_selector.dart`**: Dropdown for selecting units
- **`result_display.dart`**: Displays conversion result

---

## 🔄 Data Flow Example

Let's trace a conversion from user input to result:

### User converts 10 miles to kilometers

```
1. USER INTERACTION
   └─> ValueInput widget receives "10"

2. STATE UPDATE
   └─> conversion_state.setInputValue("10")
       └─> Parses input: 10.0
       └─> Calls _performConversion()

3. USE CASE EXECUTION
   └─> convertValueUseCase.execute(
         categoryName: 'Distance',
         value: 10.0,
         fromUnit: Unit(name: 'Miles', ...),
         toUnit: Unit(name: 'Kilometers', ...)
       )

4. REPOSITORY ACCESS
   └─> repository.convert(...)
       └─> Gets converter: _converters['Distance']
       └─> distanceConverter.convert(10.0, miles, kilometers)

5. CONVERSION LOGIC
   └─> Convert to base (meters): 10 * 1609.34 = 16093.4
   └─> Convert to target: 16093.4 / 1000 = 16.0934

6. RESULT CREATION
   └─> ConversionResult(
         inputValue: 10.0,
         fromUnit: miles,
         outputValue: 16.0934,
         toUnit: kilometers
       )

7. STATE NOTIFICATION
   └─> notifyListeners() triggers UI update

8. UI UPDATE
   └─> ListenableBuilder rebuilds
   └─> ResultDisplay shows: "16.0934 km"
```

---

## 🎯 Key Principles Applied

### Dependency Inversion Principle (DIP)

```dart
// ✅ GOOD: High-level depends on abstraction
class ConvertValueUseCase {
  final ConversionRepository repository;  // Interface
}

// ❌ BAD: High-level depends on concrete
class ConvertValueUseCase {
  final ConversionRepositoryImpl repository;  // Concrete
}
```

### Single Responsibility Principle (SRP)

Each class has ONE reason to change:
- `DistanceConverter` → Changes if distance conversion logic changes
- `CategorySelector` → Changes if category UI changes
- `ConvertValueUseCase` → Changes if conversion business rules change

### Open/Closed Principle (OCP)

Adding a new converter doesn't require modifying existing code:

```dart
// Add new converter (OPEN for extension)
class SpeedConverter extends Converter {
  @override
  List<Unit> get availableUnits => [...];
}

// Register it (one line change)
_converters['Speed'] = SpeedConverter();

// No changes to:
// - Use cases
// - Repository interface
// - Widgets
// - State management
```

---

## 🧪 Testing Strategy

### Unit Tests

```dart
// Test Domain Use Case
test('should convert 10 miles to 16.0934 kilometers', () {
  final mockRepo = MockConversionRepository();
  final useCase = ConvertValueUseCase(mockRepo);
  
  final result = useCase.execute(...);
  
  expect(result.outputValue, 16.0934);
});

// Test Data Converter
test('DistanceConverter should convert miles to kilometers', () {
  final converter = DistanceConverter();
  final miles = Unit(name: 'Miles', ...);
  final km = Unit(name: 'Kilometers', ...);
  
  final result = converter.convert(10, miles, km);
  
  expect(result, closeTo(16.0934, 0.001));
});

// Test Presentation State
test('ConversionState should update result on input change', () {
  final state = ConversionState(...);
  
  state.setInputValue('10');
  
  expect(state.result?.outputValue, isNotNull);
});
```

### Widget Tests

```dart
testWidgets('ResultDisplay shows correct value', (tester) async {
  final result = ConversionResult(...);
  
  await tester.pumpWidget(
    MaterialApp(
      home: ResultDisplay(result: result),
    ),
  );
  
  expect(find.text('16.0934'), findsOneWidget);
});
```

---

## 📈 Extending the App

### Adding a New Category (e.g., Speed)

1. **Create Converter** (Data Layer)
   ```dart
   // lib/data/converters/speed_converter.dart
   class SpeedConverter extends Converter {
     @override
     Unit get baseUnit => Unit(name: 'Meters per Second', ...);
     
     @override
     List<Unit> get availableUnits => [
       Unit(name: 'MPH', ...),
       Unit(name: 'KPH', ...),
       baseUnit,
     ];
   }
   ```

2. **Register Converter** (Data Layer)
   ```dart
   // lib/data/repositories/conversion_repository_impl.dart
   final Map<String, Converter> _converters = {
     'Distance': DistanceConverter(),
     'Weight': WeightConverter(),
     'Speed': SpeedConverter(),  // ← Add this line
   };
   ```

3. **Add Category** (Data Layer)
   ```dart
   final List<MeasurementCategory> _categories = const [
     MeasurementCategory(name: 'Distance', ...),
     MeasurementCategory(name: 'Speed', ...),  // ← Add this line
   ];
   ```

**That's it!** No changes to domain or presentation layers.

---

## 🔍 Architecture Benefits

| Benefit | Example |
|---------|---------|
| **Testability** | Each layer tested independently with mocks |
| **Maintainability** | Clear separation: UI ≠ Logic ≠ Data |
| **Scalability** | Add features without modifying existing code |
| **Flexibility** | Swap implementations (e.g., API instead of local data) |
| **Reusability** | Use cases can be used across platforms |
| **Independence** | Business logic doesn't depend on UI framework |

---

## 📚 Further Reading

- **Clean Architecture Book** by Robert C. Martin
- **SOLID Principles** documentation
- **Flutter Architecture** best practices
- See `SOLID_EXAMPLES.md` for detailed SOLID principle examples
- See `ARCHITECTURE.md` for comprehensive architecture documentation

---

## 🎓 Learning Outcomes

By studying this codebase, you'll understand:

1. ✅ How to structure a Flutter app with Clean Architecture
2. ✅ How to apply SOLID principles in practice
3. ✅ How to separate business logic from UI
4. ✅ How to use dependency injection
5. ✅ How to make code testable and maintainable
6. ✅ How to extend functionality without breaking existing code

