import '../../domain/entities/unit.dart';
import 'converter.dart';

/// Handles weight unit conversions (grams as base)
class WeightConverter extends Converter {
  @override
  Unit get baseUnit => const Unit(
        name: 'Grams',
        symbol: 'g',
        conversionFactor: 1,
        category: 'Weight',
      );

  @override
  List<Unit> get availableUnits => [
        const Unit(name: 'Pounds', symbol: 'lb', conversionFactor: 453.592, category: 'Weight'),
        const Unit(name: 'Kilograms', symbol: 'kg', conversionFactor: 1000, category: 'Weight'),
        const Unit(name: 'Ounces', symbol: 'oz', conversionFactor: 28.3495, category: 'Weight'),
        baseUnit,
        const Unit(name: 'Milligrams', symbol: 'mg', conversionFactor: 0.001, category: 'Weight'),
        const Unit(name: 'Tons', symbol: 'ton', conversionFactor: 907185, category: 'Weight'),
        const Unit(name: 'Metric Tons', symbol: 't', conversionFactor: 1000000, category: 'Weight'),
      ];
}

