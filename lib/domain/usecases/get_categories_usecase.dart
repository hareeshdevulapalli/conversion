import '../entities/measurement_category.dart';
import '../repositories/conversion_repository.dart';

/// Use Case: Get Categories - Single Responsibility Principle
class GetCategoriesUseCase {
  final ConversionRepository repository;

  GetCategoriesUseCase(this.repository);

  List<MeasurementCategory> execute() {
    return repository.getCategories();
  }
}

