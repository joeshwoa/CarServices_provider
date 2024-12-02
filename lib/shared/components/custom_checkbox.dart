import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final int index;
  final ValueChanged<int> onChanged;

  CustomCheckbox({
    required this.value,
    required this.index,
    required this.onChanged,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(index);
      },
      child: Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            width: 2.0,
            color: value
                ? ConstantColors.secondaryColor
                : ConstantColors.borderColor, // Provide fallback colors
          ),
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 18,
                color: ConstantColors.secondaryColor, // Provide fallback color
              )
            : null,
      ),
    );
  }
}
