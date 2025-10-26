import '../entities/unit.dart';
import '../entities/conversion_result.dart';
import '../repositories/conversion_repository.dart';

/// Use Case: Convert Value - Single Responsibility Principle
/// This class has one responsibility: orchestrating the conversion process
class ConvertValueUseCase {
  final ConversionRepository repository;

  ConvertValueUseCase(this.repository);

  /// Execute the conversion
  ConversionResult execute({
    required String categoryName,
    required double value,
    required Unit fromUnit,
    required Unit toUnit,
  }) {
    return repository.convert(
      categoryName: categoryName,
      value: value,
      fromUnit: fromUnit,
      toUnit: toUnit,
    );
  }
}

