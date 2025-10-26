/// Domain Entity: Represents a category of measurements
class MeasurementCategory {
  final String name;
  final String description;

  const MeasurementCategory({
    required this.name,
    required this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MeasurementCategory &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

