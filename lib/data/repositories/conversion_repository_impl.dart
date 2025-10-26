import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/measurement_category.dart';
import '../../domain/entities/unit.dart';
import '../../domain/repositories/conversion_repository.dart';
import '../converters/converter.dart';
import '../converters/distance_converter.dart';
import '../converters/weight_converter.dart';
import '../converters/temperature_converter.dart';
import '../converters/volume_converter.dart';

/// Repository implementation with category-specific converters
class ConversionRepositoryImpl implements ConversionRepository {
  final Map<String, Converter> _converters = {
    'Distance': DistanceConverter(),
    'Weight': WeightConverter(),
    'Temperature': TemperatureConverter(),
    'Volume': VolumeConverter(),
  };

  final List<MeasurementCategory> _categories = const [
    MeasurementCategory(
      name: 'Distance',
      description: 'Convert between distance units',
    ),
    MeasurementCategory(
      name: 'Weight',
      description: 'Convert between weight units',
    ),
    MeasurementCategory(
      name: 'Temperature',
      description: 'Convert between temperature units',
    ),
    MeasurementCategory(
      name: 'Volume',
      description: 'Convert between volume units',
    ),
  ];

  @override
  List<MeasurementCategory> getCategories() {
    return _categories;
  }

  @override
  List<Unit> getUnitsForCategory(String categoryName) {
    final converter = _converters[categoryName];
    if (converter == null) {
      throw Exception('Category not found: $categoryName');
    }
    return converter.availableUnits;
  }

  List<Unit> getAllUnits() {
    final List<Unit> allUnits = [];
    for (final converter in _converters.values) {
      allUnits.addAll(converter.availableUnits);
    }
    return allUnits;
  }

  @override
  ConversionResult convert({
    required String categoryName,
    required double value,
    required Unit fromUnit,
    required Unit toUnit,
  }) {
    final converter = _converters[categoryName];
    if (converter == null) {
      throw Exception('Category not found: $categoryName');
    }

    final double outputValue = converter.convert(value, fromUnit, toUnit);

    return ConversionResult(
      inputValue: value,
      fromUnit: fromUnit,
      outputValue: outputValue,
      toUnit: toUnit,
    );
  }

  /// Converts between units by auto-detecting their category
  ConversionResult convertAnyUnits({
    required double value,
    required Unit fromUnit,
    required Unit toUnit,
  }) {
    String? categoryName;
    for (final entry in _converters.entries) {
      if (entry.value.availableUnits.contains(fromUnit)) {
        categoryName = entry.key;
        break;
      }
    }

    if (categoryName == null) {
      throw Exception('Cannot find category for unit: ${fromUnit.name}');
    }

    return convert(
      categoryName: categoryName,
      value: value,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );
  }
}

