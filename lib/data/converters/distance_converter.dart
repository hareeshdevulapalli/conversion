import '../../domain/entities/unit.dart';
import 'converter.dart';

/// Handles distance unit conversions (meters as base)
class DistanceConverter extends Converter {
  @override
  Unit get baseUnit => const Unit(
        name: 'Meters',
        symbol: 'm',
        conversionFactor: 1,
        category: 'Distance',
      );

  @override
  List<Unit> get availableUnits => [
        const Unit(name: 'Miles', symbol: 'mi', conversionFactor: 1609.34, category: 'Distance'),
        const Unit(name: 'Kilometers', symbol: 'km', conversionFactor: 1000, category: 'Distance'),
        baseUnit,
        const Unit(name: 'Feet', symbol: 'ft', conversionFactor: 0.3048, category: 'Distance'),
        const Unit(name: 'Inches', symbol: 'in', conversionFactor: 0.0254, category: 'Distance'),
        const Unit(name: 'Yards', symbol: 'yd', conversionFactor: 0.9144, category: 'Distance'),
        const Unit(name: 'Centimeters', symbol: 'cm', conversionFactor: 0.01, category: 'Distance'),
      ];
}

