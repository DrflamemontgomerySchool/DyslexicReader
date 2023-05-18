import 'package:flutter/material.dart';

class LabeledCheckBox extends StatelessWidget {
  const LabeledCheckBox({
    super.key,
    required this.onChanged,
    required this.value,
    required this.label,
  });

  final ValueChanged<bool?> onChanged;
  final bool value;
  final Widget label;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Row(
        children: [
          label,
          Checkbox(
            onChanged: onChanged,
            value: value,
          ),
        ],
      ),
    );
  }
}
