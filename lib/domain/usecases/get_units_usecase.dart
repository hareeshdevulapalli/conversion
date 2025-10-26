import '../entities/unit.dart';
import '../repositories/conversion_repository.dart';

/// Use Case: Get Units for Category - Single Responsibility Principle
class GetUnitsUseCase {
  final ConversionRepository repository;

  GetUnitsUseCase(this.repository);

  List<Unit> execute(String categoryName) {
    return repository.getUnitsForCategory(categoryName);
  }
}

