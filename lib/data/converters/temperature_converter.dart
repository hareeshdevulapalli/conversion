import '../../domain/entities/unit.dart';
import 'converter.dart';

/// Handles temperature unit conversions with custom logic (Celsius as base)
class TemperatureConverter extends Converter {
  @override
  Unit get baseUnit => const Unit(
        name: 'Celsius',
        symbol: '°C',
        conversionFactor: 1,
        category: 'Temperature',
      );

  @override
  List<Unit> get availableUnits => [
        const Unit(name: 'Fahrenheit', symbol: '°F', conversionFactor: 1, category: 'Temperature'),
        baseUnit,
        const Unit(name: 'Kelvin', symbol: 'K', conversionFactor: 1, category: 'Temperature'),
      ];

  @override
  double convert(double value, Unit from, Unit to) {
    if (from == to) return value;
    double celsius = _convertToCelsius(value, from);
    return _convertFromCelsius(celsius, to);
  }

  double _convertToCelsius(double value, Unit from) {
    switch (from.name) {
      case 'Celsius':
        return value;
      case 'Fahrenheit':
        return (value - 32) * 5 / 9;
      case 'Kelvin':
        return value - 273.15;
      default:
        return value;
    }
  }

  double _convertFromCelsius(double celsius, Unit to) {
    switch (to.name) {
      case 'Celsius':
        return celsius;
      case 'Fahrenheit':
        return (celsius * 9 / 5) + 32;
      case 'Kelvin':
        return celsius + 273.15;
      default:
        return celsius;
    }
  }

  @override
  double convertToBase(double value, Unit unit) => _convertToCelsius(value, unit);

  @override
  double convertFromBase(double baseValue, Unit unit) =>
      _convertFromCelsius(baseValue, unit);
}

