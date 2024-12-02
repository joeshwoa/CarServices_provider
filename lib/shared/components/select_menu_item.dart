import 'package:autoflex/main.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectMenuItem<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String? layout;
  final String? title;

  const SelectMenuItem({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.layout = 'column',
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: value != groupValue
                  ? ConstantColors.backgroundColor
                  : ConstantColors.primaryColor,
              border: Border.all(
                  color: value != groupValue
                      ? ConstantColors.borderColor
                      : ConstantColors.primaryColor),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Text(
            textAlign: layout == 'column' ? TextAlign.start : TextAlign.center,
            title!,
            style: value != groupValue
                ? Theme.of(context).textTheme.labelMedium
                : TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.cardColor,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont'),
          ),
        ),
      ),
    );
  }
}
