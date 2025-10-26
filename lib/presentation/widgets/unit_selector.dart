import 'package:flutter/material.dart';
import '../../domain/entities/unit.dart';

/// Dropdown selector for choosing units with "None" option
class UnitSelector extends StatelessWidget {
  final String label;
  final List<Unit> units;
  final Unit? selectedUnit;
  final Function(Unit?) onUnitSelected;
  final Color? fillColor;

  const UnitSelector({
    super.key,
    required this.label,
    required this.units,
    required this.selectedUnit,
    required this.onUnitSelected,
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[700],
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<Unit?>(
          value: selectedUnit,
          decoration: const InputDecoration(
            border: UnderlineInputBorder(),
          ),
          style: const TextStyle(
            color: Colors.blue,
            fontSize: 16,
          ),
          menuMaxHeight: 300,
          items: [
            const DropdownMenuItem<Unit?>(
              value: null,
              child: Text('None'),
            ),
            ...units.map((unit) {
              return DropdownMenuItem<Unit?>(
                value: unit,
                child: Text('${unit.name} (${unit.symbol})'),
              );
            }).toList(),
          ],
          onChanged: (unit) {
            onUnitSelected(unit);
          },
        ),
      ],
    );
  }
}

