import '../entities/measurement_category.dart';
import '../entities/unit.dart';
import '../entities/conversion_result.dart';

/// Repository Interface - Dependency Inversion Principle
/// Domain layer defines the interface, data layer implements it
abstract class ConversionRepository {
  /// Get all available measurement categories
  List<MeasurementCategory> getCategories();

  /// Get units for a specific category
  List<Unit> getUnitsForCategory(String categoryName);

  /// Convert a value from one unit to another within the same category
  ConversionResult convert({
    required String categoryName,
    required double value,
    required Unit fromUnit,
    required Unit toUnit,
  });
}

