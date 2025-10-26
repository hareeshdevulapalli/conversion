import 'unit.dart';

/// Domain Entity: Represents the result of a conversion
class ConversionResult {
  final double inputValue;
  final Unit fromUnit;
  final double outputValue;
  final Unit toUnit;

  const ConversionResult({
    required this.inputValue,
    required this.fromUnit,
    required this.outputValue,
    required this.toUnit,
  });

  String get formattedOutput {
    String result = outputValue.toStringAsFixed(4);
    // Remove trailing zeros and decimal point if not needed
    result = result.replaceAll(RegExp(r'\.?0*$'), '');
    return result;
  }
}

