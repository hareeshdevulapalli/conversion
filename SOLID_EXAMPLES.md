# SOLID Principles - Practical Examples

This document provides concrete examples from the codebase demonstrating each SOLID principle.

---

## S - Single Responsibility Principle (SRP)

> A class should have one, and only one, reason to change.

### ✅ Good Examples in Our Code

#### 1. Converter Classes
Each converter has one responsibility:

```dart
// lib/data/converters/distance_converter.dart
class DistanceConverter extends Converter {
  // ONLY converts distance units
  // No UI logic, no state management, no data persistence
}
```

#### 2. Widget Classes
Each widget has a single UI responsibility:

```dart
// lib/presentation/widgets/category_selector.dart
class CategorySelector extends StatelessWidget {
  // ONLY displays and handles category selection
  // Doesn't handle conversions, state, or other widgets
}

// lib/presentation/widgets/result_display.dart
class ResultDisplay extends StatelessWidget {
  // ONLY displays the conversion result
  // Doesn't handle input or calculations
}
```

#### 3. Use Case Classes
Each use case has one business operation:

```dart
// lib/domain/usecases/convert_value_usecase.dart
class ConvertValueUseCase {
  // ONLY orchestrates conversion logic
  ConversionResult execute(...) { ... }
}

// lib/domain/usecases/get_categories_usecase.dart
class GetCategoriesUseCase {
  // ONLY retrieves categories
  List<MeasurementCategory> execute() { ... }
}
```

### ❌ What We Avoided (Bad Example)

```dart
// DON'T DO THIS - Multiple responsibilities
class MegaConverter {
  // Handles conversion ❌
  double convert() { ... }
  
  // Manages UI state ❌
  void updateUI() { ... }
  
  // Handles data persistence ❌
  void saveToDatabase() { ... }
  
  // Validates input ❌
  bool validateInput() { ... }
}
```

---

## O - Open/Closed Principle (OCP)

> Software entities should be open for extension, but closed for modification.

### ✅ Good Examples in Our Code

#### 1. Converter Extension
Adding new converters doesn't require modifying existing code:

```dart
// lib/data/converters/converter.dart
abstract class Converter {
  // Base implementation - CLOSED for modification
  double convert(double value, Unit from, Unit to) {
    // ... base logic
  }
}

// Adding a new converter - OPEN for extension
class SpeedConverter extends Converter {
  // New converter without modifying Converter class
  @override
  List<Unit> get availableUnits => [
    Unit(name: 'MPH', ...),
    Unit(name: 'KPH', ...),
  ];
}
```

#### 2. Repository Pattern
Can add new data sources without changing use cases:

```dart
// Domain defines interface (closed for modification)
abstract class ConversionRepository {
  ConversionResult convert(...);
}

// Can add new implementations (open for extension)
class ConversionRepositoryImpl implements ConversionRepository { ... }
class CachedConversionRepository implements ConversionRepository { ... }
class RemoteConversionRepository implements ConversionRepository { ... }

// Use cases don't change!
class ConvertValueUseCase {
  final ConversionRepository repository; // Uses interface
}
```

### ❌ What We Avoided (Bad Example)

```dart
// DON'T DO THIS - Requires modification to add new features
class ConversionService {
  double convert(String category, double value, String from, String to) {
    if (category == 'Distance') {
      // distance logic
    } else if (category == 'Weight') {
      // weight logic
    }
    // Adding new category requires modifying this method ❌
  }
}
```

---

## L - Liskov Substitution Principle (LSP)

> Derived classes must be substitutable for their base classes.

### ✅ Good Examples in Our Code

#### 1. Converter Substitution
Any converter can replace another:

```dart
// lib/data/repositories/conversion_repository_impl.dart
final Map<String, Converter> _converters = {
  'Distance': DistanceConverter(),
  'Weight': WeightConverter(),
  'Temperature': TemperatureConverter(),  // Special case, still works!
  'Volume': VolumeConverter(),
};

// All converters work the same way
Converter converter = _converters['Distance']!;
double result = converter.convert(10, fromUnit, toUnit);

// Can swap with any other converter
converter = _converters['Weight']!;
result = converter.convert(10, fromUnit, toUnit);  // Still works!
```

#### 2. Temperature Converter Special Case
Even though TemperatureConverter has special logic, it still upholds the contract:

```dart
// lib/data/converters/temperature_converter.dart
class TemperatureConverter extends Converter {
  // Overrides behavior but maintains contract
  @override
  double convert(double value, Unit from, Unit to) {
    // Different implementation, same interface
    double celsius = _convertToCelsius(value, from);
    return _convertFromCelsius(celsius, to);
  }
}
```

### ✅ The Contract is Maintained

```dart
// Anywhere a Converter is expected, any implementation works
void performConversion(Converter converter, double value, Unit from, Unit to) {
  double result = converter.convert(value, from, to);
  // Works for ALL converter types
}
```

### ❌ What We Avoided (Bad Example)

```dart
// DON'T DO THIS - Violates LSP
class BrokenConverter extends Converter {
  @override
  double convert(double value, Unit from, Unit to) {
    throw UnimplementedError(); // ❌ Breaks contract
  }
}

class NullReturningConverter extends Converter {
  @override
  double? convert(double value, Unit from, Unit to) {
    return null; // ❌ Changes return type contract
  }
}
```

---

## I - Interface Segregation Principle (ISP)

> No client should be forced to depend on methods it does not use.

### ✅ Good Examples in Our Code

#### 1. Focused Use Cases
Each use case has a specific interface:

```dart
// lib/domain/usecases/get_categories_usecase.dart
class GetCategoriesUseCase {
  final ConversionRepository repository;
  
  // Only uses getCategories() method
  List<MeasurementCategory> execute() {
    return repository.getCategories();  // Uses only what it needs
  }
}

// lib/domain/usecases/convert_value_usecase.dart
class ConvertValueUseCase {
  final ConversionRepository repository;
  
  // Only uses convert() method
  ConversionResult execute(...) {
    return repository.convert(...);  // Uses only what it needs
  }
}
```

#### 2. Focused Widgets
Each widget depends only on what it needs:

```dart
// lib/presentation/widgets/category_selector.dart
class CategorySelector extends StatelessWidget {
  final List<MeasurementCategory> categories;  // Only needs categories
  final MeasurementCategory? selectedCategory;
  final Function(MeasurementCategory) onCategorySelected;
  
  // Doesn't need conversion logic, units, or results
}

// lib/presentation/widgets/result_display.dart
class ResultDisplay extends StatelessWidget {
  final ConversionResult? result;  // Only needs result
  final String? error;
  
  // Doesn't need input, categories, or units
}
```

### ❌ What We Avoided (Bad Example)

```dart
// DON'T DO THIS - Fat interface
abstract class MegaRepository {
  // Too many methods in one interface
  List<Category> getCategories();
  List<Unit> getUnits();
  ConversionResult convert();
  void saveSettings();
  void loadSettings();
  User getUser();
  void updateUser();
  // ... 20 more methods
}

// Forces clients to depend on methods they don't use
class SimpleUseCase {
  final MegaRepository repository;  // ❌ Depends on too much
  
  execute() {
    return repository.getCategories();  // Only uses 1 of 20 methods
  }
}
```

---

## D - Dependency Inversion Principle (DIP)

> Depend on abstractions, not concretions.

### ✅ Good Examples in Our Code

#### 1. Use Cases Depend on Abstractions

```dart
// lib/domain/usecases/convert_value_usecase.dart
class ConvertValueUseCase {
  // Depends on INTERFACE, not implementation
  final ConversionRepository repository;  // ✅ Abstract
  
  ConvertValueUseCase(this.repository);
}

// NOT this:
// final ConversionRepositoryImpl repository;  // ❌ Concrete
```

#### 2. Dependency Injection in main.dart

```dart
// lib/main.dart
void main() {
  // Create concrete implementation
  final ConversionRepository repository = ConversionRepositoryImpl();
  
  // Inject abstraction into use cases
  final ConvertValueUseCase convertValueUseCase = 
      ConvertValueUseCase(repository);  // ✅ DI via constructor
  
  // Use cases work with abstraction
}
```

#### 3. State Depends on Use Cases (Abstractions)

```dart
// lib/presentation/state/conversion_state.dart
class ConversionState extends ChangeNotifier {
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetUnitsUseCase getUnitsUseCase;
  final ConvertValueUseCase convertValueUseCase;
  
  // Depends on use cases, not on repository directly
  ConversionState({
    required this.getCategoriesUseCase,
    required this.getUnitsUseCase,
    required this.convertValueUseCase,
  });
}
```

### 📊 Dependency Flow

```
High-Level (Presentation)
         ↓ depends on
Medium-Level (Use Cases/Abstractions)
         ↑ implements
Low-Level (Repository Implementations)
```

### ✅ Benefits

```dart
// Easy to test with mocks
class MockRepository implements ConversionRepository {
  @override
  ConversionResult convert(...) => mockResult;
}

final useCase = ConvertValueUseCase(MockRepository());  // ✅ Works!

// Easy to swap implementations
final useCase1 = ConvertValueUseCase(LocalRepository());
final useCase2 = ConvertValueUseCase(RemoteRepository());
final useCase3 = ConvertValueUseCase(CachedRepository());
// All work without changing use case code!
```

### ❌ What We Avoided (Bad Example)

```dart
// DON'T DO THIS - Depends on concrete implementation
class BadUseCase {
  final ConversionRepositoryImpl repository;  // ❌ Concrete class
  
  BadUseCase() {
    repository = ConversionRepositoryImpl();  // ❌ Direct instantiation
  }
}

// Hard to test, hard to swap implementations
// Tightly coupled to specific implementation
```

---

## Summary: SOLID Benefits in Our App

| Principle | Benefit in Our Code |
|-----------|---------------------|
| **SRP** | Each class is small, focused, and easy to understand |
| **OCP** | Can add new converters without changing existing code |
| **LSP** | All converters work interchangeably |
| **ISP** | Widgets and use cases only depend on what they need |
| **DIP** | Easy to test and swap implementations |

### Overall Result

✅ **Testable**: Can mock dependencies
✅ **Flexible**: Can swap implementations  
✅ **Maintainable**: Clear responsibilities  
✅ **Scalable**: Easy to add features  
✅ **Readable**: Self-documenting code structure

