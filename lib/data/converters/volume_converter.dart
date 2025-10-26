import '../../domain/entities/unit.dart';
import 'converter.dart';

/// Handles volume unit conversions (liters as base)
class VolumeConverter extends Converter {
  @override
  Unit get baseUnit => const Unit(
        name: 'Liters',
        symbol: 'L',
        conversionFactor: 1,
        category: 'Volume',
      );

  @override
  List<Unit> get availableUnits => [
        const Unit(name: 'Gallons', symbol: 'gal', conversionFactor: 3.78541, category: 'Volume'),
        baseUnit,
        const Unit(name: 'Milliliters', symbol: 'mL', conversionFactor: 0.001, category: 'Volume'),
        const Unit(name: 'Cups', symbol: 'cup', conversionFactor: 0.236588, category: 'Volume'),
        const Unit(name: 'Fluid Ounces', symbol: 'fl oz', conversionFactor: 0.0295735, category: 'Volume'),
        const Unit(name: 'Pints', symbol: 'pt', conversionFactor: 0.473176, category: 'Volume'),
        const Unit(name: 'Quarts', symbol: 'qt', conversionFactor: 0.946353, category: 'Volume'),
      ];
}

