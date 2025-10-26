import 'package:flutter/material.dart';
import '../state/conversion_state.dart';
import '../widgets/value_input.dart';
import '../widgets/unit_selector.dart';
import '../widgets/result_display.dart';

/// Main conversion page with minimalist UI
/// Displays value input, unit selectors, convert button, and result
class ConversionPage extends StatelessWidget {
  final ConversionState state;

  const ConversionPage({
    super.key,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measures Converter',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blue,
      ),
      body: ListenableBuilder(
        listenable: state,
        builder: (context, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ValueInput(
                    value: state.inputValue,
                    onValueChanged: state.setInputValue,
                    onClear: state.clearInput,
                  ),
                  const SizedBox(height: 16),
                  UnitSelector(
                    label: 'From',
                    units: state.availableUnits,
                    selectedUnit: state.fromUnit,
                    onUnitSelected: state.setFromUnit,
                  ),
                  const SizedBox(height: 16),
                  // To dropdown shows only units from same category as From
                  UnitSelector(
                    label: 'To',
                    units: state.availableToUnits,
                    selectedUnit: state.toUnit,
                    onUnitSelected: state.setToUnit,
                  ),
                  const SizedBox(height: 24),
                  // Button enabled only when all fields are filled
                  Center(
                    child: ElevatedButton(
                      onPressed: state.inputValue.isNotEmpty &&
                              state.fromUnit != null &&
                              state.toUnit != null
                          ? state.convert
                          : null,
                      style: ElevatedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Convert'),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ResultDisplay(
                    result: state.result,
                    error: state.error,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

