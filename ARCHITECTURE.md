# Architecture Documentation

This document explains the Clean Architecture and SOLID principles implemented in this Flutter Conversion App.

## Clean Architecture

The application follows Clean Architecture principles with three distinct layers:

```
lib/
├── domain/              # Business Logic Layer (Innermost)
│   ├── entities/        # Business entities
│   ├── repositories/    # Repository interfaces
│   └── usecases/        # Business use cases
│
├── data/                # Data Layer (Middle)
│   ├── converters/      # Conversion implementations
│   └── repositories/    # Repository implementations
│
└── presentation/        # Presentation Layer (Outermost)
    ├── pages/           # UI pages
    ├── widgets/         # Reusable widgets
    └── state/           # State management
```

### Layer Dependencies

```
Presentation → Domain ← Data
```

- **Presentation** depends on **Domain**
- **Data** depends on **Domain**
- **Domain** depends on nothing (pure business logic)

### Benefits

1. **Independence**: Business logic is independent of UI and frameworks
2. **Testability**: Each layer can be tested in isolation
3. **Flexibility**: Easy to swap implementations (e.g., change data sources)
4. **Maintainability**: Clear separation of concerns

---

## SOLID Principles

### 1. Single Responsibility Principle (SRP)

Each class has one reason to change.

**Examples:**

- `DistanceConverter` - Only handles distance conversions
- `CategorySelector` - Only handles category selection UI
- `ConvertValueUseCase` - Only orchestrates conversion logic
- `ResultDisplay` - Only displays conversion results

```dart
// ✅ Good: Single responsibility
class DistanceConverter extends Converter {
  // Only handles distance conversions
}

// ❌ Bad: Multiple responsibilities
class ConverterAndDisplay {
  // Handles conversion AND UI display
}
```

### 2. Open/Closed Principle (OCP)

Open for extension, closed for modification.

**Examples:**

The `Converter` abstract class allows adding new converters without modifying existing code:

```dart
abstract class Converter {
  double convert(double value, Unit from, Unit to);
}

// Adding a new converter doesn't modify existing code
class DistanceConverter extends Converter { ... }
class WeightConverter extends Converter { ... }
class TemperatureConverter extends Converter { ... }  // New converter
```

### 3. Liskov Substitution Principle (LSP)

Derived classes must be substitutable for their base classes.

**Examples:**

Any `Converter` implementation can be used wherever a `Converter` is expected:

```dart
Converter converter = DistanceConverter();  // Works
converter = WeightConverter();              // Also works
converter = TemperatureConverter();         // Still works

// All implementations can be used interchangeably
double result = converter.convert(10, fromUnit, toUnit);
```

### 4. Interface Segregation Principle (ISP)

Clients should not depend on interfaces they don't use.

**Examples:**

We have focused interfaces for specific purposes:

```dart
// ✅ Good: Specific interfaces
abstract class ConversionRepository {
  List<MeasurementCategory> getCategories();
  List<Unit> getUnitsForCategory(String categoryName);
  ConversionResult convert(...);
}

// Each use case uses only what it needs
class GetCategoriesUseCase {
  // Only uses getCategories()
}

class ConvertValueUseCase {
  // Only uses convert()
}
```

### 5. Dependency Inversion Principle (DIP)

High-level modules should not depend on low-level modules. Both should depend on abstractions.

**Examples:**

```dart
// ✅ Good: Depends on abstraction
class ConvertValueUseCase {
  final ConversionRepository repository;  // Interface, not implementation
  ConvertValueUseCase(this.repository);
}

// Dependency injection in main.dart
final ConversionRepository repository = ConversionRepositoryImpl();
final useCase = ConvertValueUseCase(repository);
```

The use case depends on the `ConversionRepository` interface, not the concrete implementation. This allows us to:
- Swap implementations easily
- Test with mock repositories
- Change data sources without affecting business logic

---

## Design Patterns

### 1. Repository Pattern

Abstracts data access logic.

```dart
// Interface in domain layer
abstract class ConversionRepository { ... }

// Implementation in data layer
class ConversionRepositoryImpl implements ConversionRepository { ... }
```

### 2. Strategy Pattern

Different conversion strategies for different categories.

```dart
final Map<String, Converter> _converters = {
  'Distance': DistanceConverter(),
  'Weight': WeightConverter(),
  'Temperature': TemperatureConverter(),
  'Volume': VolumeConverter(),
};
```

### 3. Observer Pattern (via Flutter)

State management using `ChangeNotifier` and `ListenableBuilder`.

```dart
class ConversionState extends ChangeNotifier {
  void setInputValue(String value) {
    _inputValue = value;
    notifyListeners();  // Notifies observers
  }
}
```

---

## Data Flow

1. **User Input** → Presentation Layer (Widget)
2. **Widget** → State (ConversionState)
3. **State** → Use Case (ConvertValueUseCase)
4. **Use Case** → Repository Interface (ConversionRepository)
5. **Repository** → Converter (DistanceConverter, etc.)
6. **Result** ← Back through layers to UI

```
UI Widget → State → UseCase → Repository → Converter
                                               ↓
UI Widget ← State ← UseCase ← Repository ← Result
```

---

## Testing Strategy

### Unit Tests

- **Domain Layer**: Test use cases and entities
- **Data Layer**: Test converters and repository
- **Presentation Layer**: Test state management

### Integration Tests

- Test complete flows through multiple layers

### Widget Tests

- Test individual widgets in isolation

### Example Test Structure

```dart
// Test Use Case
test('ConvertValueUseCase should convert correctly', () {
  final mockRepo = MockConversionRepository();
  final useCase = ConvertValueUseCase(mockRepo);
  
  final result = useCase.execute(...);
  
  expect(result.outputValue, expectedValue);
});
```

---

## Adding New Features

### Adding a New Unit Category

1. **Create Converter** (Data Layer)
   ```dart
   class SpeedConverter extends Converter { ... }
   ```

2. **Register in Repository** (Data Layer)
   ```dart
   _converters['Speed'] = SpeedConverter();
   ```

3. **Add Category** (Data Layer)
   ```dart
   MeasurementCategory(name: 'Speed', description: '...')
   ```

4. **No changes needed** in Domain or Presentation layers!

### Adding a New Unit to Existing Category

1. **Update Converter** (Data Layer only)
   ```dart
   availableUnits.add(Unit(name: 'Nautical Miles', ...));
   ```

---

## Key Takeaways

✅ **Clean Architecture ensures:**
- Business logic is independent
- Easy to test
- Easy to maintain
- Easy to extend

✅ **SOLID Principles ensure:**
- Each class has one job
- Code is open for extension
- Implementations are interchangeable
- Interfaces are focused
- Dependencies are inverted

✅ **Benefits:**
- **Scalability**: Easy to add features
- **Testability**: Each layer can be tested independently
- **Maintainability**: Clear structure and responsibilities
- **Flexibility**: Easy to change implementations

