import 'package:flutter/foundation.dart';
import '../../domain/entities/conversion_result.dart';
import '../../domain/entities/unit.dart';
import '../../data/repositories/conversion_repository_impl.dart';

/// State management for conversion page
/// Handles unit selection, smart filtering, and conversion logic
class ConversionState extends ChangeNotifier {
  final ConversionRepositoryImpl repository;

  ConversionState({
    required this.repository,
  }) {
    _initialize();
  }

  List<Unit> _availableUnits = [];
  Unit? _fromUnit;
  Unit? _toUnit;
  String _inputValue = '';
  ConversionResult? _result;
  String? _error;

  List<Unit> get availableUnits => _availableUnits;
  Unit? get fromUnit => _fromUnit;
  Unit? get toUnit => _toUnit;
  String get inputValue => _inputValue;
  ConversionResult? get result => _result;
  String? get error => _error;
  
  /// Returns filtered units for "To" dropdown based on "From" unit's category
  /// If no "From" unit selected, returns all units
  List<Unit> get availableToUnits {
    if (_fromUnit == null) return _availableUnits;
    return _availableUnits
        .where((unit) => unit.category == _fromUnit!.category)
        .toList();
  }

  void _initialize() {
    _availableUnits = repository.getAllUnits();
    _fromUnit = null;
    _toUnit = null;
  }

  /// Updates "From" unit and resets "To" if categories don't match
  void setFromUnit(Unit? unit) {
    _fromUnit = unit;
    
    if (unit == null) {
      _result = null;
      _error = null;
    } else if (_toUnit != null && _toUnit!.category != unit.category) {
      _toUnit = null;
      _result = null;
      _error = null;
    }
    
    notifyListeners();
  }

  void setToUnit(Unit? unit) {
    _toUnit = unit;
    
    if (unit == null) {
      _result = null;
      _error = null;
    }
    
    notifyListeners();
  }

  void setInputValue(String value) {
    _inputValue = value;
    notifyListeners();
  }

  void clearInput() {
    _inputValue = '';
    _result = null;
    _error = null;
    notifyListeners();
  }

  /// Performs conversion when Convert button is clicked
  void convert() {
    _performConversion();
    notifyListeners();
  }

  void _performConversion() {
    if (_inputValue.isEmpty ||
        _fromUnit == null ||
        _toUnit == null) {
      _result = null;
      _error = null;
      return;
    }

    try {
      final double value = double.parse(_inputValue);
      _result = repository.convertAnyUnits(
        value: value,
        fromUnit: _fromUnit!,
        toUnit: _toUnit!,
      );
      _error = null;
    } catch (e) {
      _error = 'Invalid conversion: ${e.toString()}';
      _result = null;
    }
  }
}

