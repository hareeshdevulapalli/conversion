import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Input field for entering numeric value to convert
class ValueInput extends StatelessWidget {
  final String value;
  final Function(String) onValueChanged;
  final VoidCallback onClear;

  const ValueInput({
    super.key,
    required this.value,
    required this.onValueChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Value',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: TextEditingController(text: value)
            ..selection = TextSelection.fromPosition(
              TextPosition(offset: value.length),
            ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ],
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
          ),
          onChanged: onValueChanged,
        ),
      ],
    );
  }
}

