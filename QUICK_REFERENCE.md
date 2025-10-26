# Quick Reference Card

## 🚀 Running the App

```bash
# Get dependencies
flutter pub get

# Run on web (no Xcode needed)
flutter run -d chrome

# Run on macOS (requires Xcode)
flutter run -d macos

# Run on Android/iOS
flutter run -d android
flutter run -d ios
```

---

## 📂 Project Structure

```
lib/
├── main.dart                 # Entry point & DI setup
├── domain/                   # Business logic (no dependencies)
│   ├── entities/             # Business objects
│   ├── repositories/         # Interfaces
│   └── usecases/             # Business operations
├── data/                     # Implementation details
│   ├── converters/           # Conversion algorithms
│   └── repositories/         # Repository implementation
└── presentation/             # UI layer
    ├── pages/                # Screens
    ├── widgets/              # UI components
    └── state/                # State management
```

---

## 🎯 SOLID Principles Quick Reference

| Principle | In This App |
|-----------|-------------|
| **S**ingle Responsibility | Each class has ONE job |
| **O**pen/Closed | Add new converters without modifying existing code |
| **L**iskov Substitution | All converters work interchangeably |
| **I**nterface Segregation | Widgets/use cases depend only on what they need |
| **D**ependency Inversion | Depend on interfaces, not implementations |

---

## 🏗️ Clean Architecture Layers

| Layer | Contains | Depends On |
|-------|----------|------------|
| **Domain** | Entities, Use Cases, Interfaces | Nothing |
| **Data** | Converters, Repository Impl | Domain |
| **Presentation** | Widgets, Pages, State | Domain |

**Key Rule:** Dependencies point inward (toward Domain)

---

## 🔄 Adding a New Category

1. Create converter in `data/converters/`:
   ```dart
   class NewConverter extends Converter {
     @override
     Unit get baseUnit => ...;
     @override
     List<Unit> get availableUnits => [...];
   }
   ```

2. Register in `data/repositories/conversion_repository_impl.dart`:
   ```dart
   _converters['NewCategory'] = NewConverter();
   _categories.add(MeasurementCategory(name: 'NewCategory', ...));
   ```

3. Done! No other changes needed.

---

## 🧪 Testing Commands

```bash
# Run all tests
flutter test

# Run specific test
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage
```

---

## 📊 Current Features

### Conversion Categories
- ✅ Distance (Miles, Kilometers, Meters, Feet, etc.)
- ✅ Weight (Pounds, Kilograms, Ounces, Grams, etc.)
- ✅ Temperature (Fahrenheit, Celsius, Kelvin)
- ✅ Volume (Gallons, Liters, Milliliters, Cups, etc.)

### UI Features
- ✅ Real-time conversion
- ✅ Unit swap button
- ✅ Input validation
- ✅ Clean Material Design 3 UI
- ✅ Category selection
- ✅ Error handling

---

## 🔍 Key Files to Study

| File | Purpose | SOLID Principle |
|------|---------|----------------|
| `domain/usecases/convert_value_usecase.dart` | Business logic | SRP, DIP |
| `data/converters/converter.dart` | Base converter | OCP, LSP |
| `data/repositories/conversion_repository_impl.dart` | Repository impl | DIP, ISP |
| `presentation/state/conversion_state.dart` | State management | SRP, DIP |
| `presentation/widgets/category_selector.dart` | UI component | SRP, ISP |

---

## 📖 Documentation Files

- **`README.md`** - Project overview and setup
- **`ARCHITECTURE.md`** - Detailed architecture explanation
- **`SOLID_EXAMPLES.md`** - Concrete SOLID principle examples
- **`CLEAN_ARCHITECTURE_GUIDE.md`** - Comprehensive architecture guide
- **`QUICK_REFERENCE.md`** - This file (quick lookup)

---

## 💡 Code Conventions

### Naming
- Classes: `PascalCase`
- Files: `snake_case.dart`
- Private members: `_leadingUnderscore`

### Organization
- One class per file
- Group imports: flutter → package → relative
- Use `const` constructors where possible

### Comments
- Document WHY, not WHAT
- Use `///` for public API documentation
- Keep comments up to date

---

## 🐛 Common Issues

### Issue: Build fails on macOS
**Solution:** Install Xcode (not just Command Line Tools)
```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
```

### Issue: Hot reload not working
**Solution:** Stop and restart the app
```bash
flutter run
```

### Issue: Dependencies not found
**Solution:** Get dependencies
```bash
flutter pub get
```

---

## 📝 Git Workflow

```bash
# Check status
git status

# Add files
git add .

# Commit
git commit -m "feat: descriptive message"

# Push
git push origin main
```

---

## 🎓 Learning Path

1. ✅ Study `ARCHITECTURE.md` for overview
2. ✅ Read `SOLID_EXAMPLES.md` for principles
3. ✅ Follow `CLEAN_ARCHITECTURE_GUIDE.md` for details
4. ✅ Explore code in this order:
   - Domain layer (start here - no dependencies)
   - Data layer (implementations)
   - Presentation layer (UI)

---

## 🚀 Next Steps

Want to improve the app? Try:

1. **Add Unit Tests** - Test converters and use cases
2. **Add New Category** - Try adding "Speed" or "Area"
3. **Add History** - Store past conversions
4. **Add Favorites** - Save frequently used conversions
5. **Add Dark Mode** - Implement theme switching
6. **Add Localization** - Support multiple languages

---

## 💬 Quick Tips

- Use `flutter doctor` to check setup
- Use `flutter clean` if build acts weird
- Use hot reload (`r` in terminal) for quick changes
- Use hot restart (`R` in terminal) for state reset
- Use `flutter analyze` to check for issues

---

## 📚 Helpful Commands

```bash
flutter doctor              # Check environment
flutter clean               # Clean build artifacts
flutter pub get             # Get dependencies
flutter pub upgrade         # Upgrade dependencies
flutter analyze             # Run static analysis
flutter test                # Run tests
flutter build apk           # Build Android APK
flutter build ios           # Build iOS app
```

---

**Happy Coding! 🎉**

