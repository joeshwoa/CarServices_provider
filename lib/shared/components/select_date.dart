import 'package:autoflex/controllers/Company_data/bussines%20hours/block_days_controller.dart';
import 'package:autoflex/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/colors.dart';

class SelectDate<T> extends StatelessWidget {
  final T value;
  final RxList<String> groupValue;
  final ValueChanged<T> onChanged;
  final String? layout;
  final String? title;

  SelectDate({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.title,
    this.layout = 'column',
  });

  BlockDaysController blockDaysController = Get.find<BlockDaysController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onChanged(value),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: groupValue.contains(value)
                ? ConstantColors.errorColor
                : ConstantColors.backgroundColor,
            border: Border.all(color: ConstantColors.borderColor),
            borderRadius: const BorderRadius.all(Radius.circular(8)),
          ),
          child: Text(
            title!,
            textAlign: layout == 'column' ? TextAlign.start : TextAlign.center,
            style: groupValue.contains(value)
                ? TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: ConstantColors.bodyColor2,
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont')
                : Theme.of(context).textTheme.labelMedium,
          ),
        ),
      ),
    );
  }
}
