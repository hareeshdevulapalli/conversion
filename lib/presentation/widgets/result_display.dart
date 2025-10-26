import 'package:flutter/material.dart';
import '../../domain/entities/conversion_result.dart';

/// Displays conversion result in natural language format
class ResultDisplay extends StatelessWidget {
  final ConversionResult? result;
  final String? error;

  const ResultDisplay({
    super.key,
    required this.result,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    if (error != null) {
      return Text(
        error!,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.red,
        ),
        textAlign: TextAlign.center,
      );
    }

    if (result == null) {
      return const SizedBox.shrink();
    }

    final String message = 
        '${result!.inputValue} ${result!.fromUnit.name.toLowerCase()} '
        '${result!.inputValue == 1 ? 'is' : 'are'} '
        '${result!.formattedOutput} ${result!.toUnit.name.toLowerCase()}';

    return Text(
      message,
      style: TextStyle(
        fontSize: 16,
        color: Colors.grey[700],
      ),
      textAlign: TextAlign.center,
    );
  }
}

