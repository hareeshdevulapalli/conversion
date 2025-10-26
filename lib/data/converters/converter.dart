import '../../domain/entities/unit.dart';

/// Base converter interface for all unit conversions
/// Subclasses define category-specific units and conversion logic
abstract class Converter {
  Unit get baseUnit;
  List<Unit> get availableUnits;

  /// Converts value from one unit to another via base unit
  double convert(double value, Unit from, Unit to) {
    if (from == to) return value;
    final double baseValue = convertToBase(value, from);
    return convertFromBase(baseValue, to);
  }

  double convertToBase(double value, Unit unit) {
    return value * unit.conversionFactor;
  }

  double convertFromBase(double baseValue, Unit unit) {
    return baseValue / unit.conversionFactor;
  }
}

