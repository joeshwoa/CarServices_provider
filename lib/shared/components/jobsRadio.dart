import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';
import '../styles/colors.dart';

class JobsRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;
  final String? customIcon;
  final String? title;

  const JobsRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.customIcon,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color:value == groupValue?ConstantColors.secondaryColor: ConstantColors.cardColor,
            border: value == groupValue
                ? Border.all(color: ConstantColors.secondaryColor)
                :  Border.all(
                    
                        width: 1, color: ConstantColors.borderColor),
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          children: <Widget>[
            value != groupValue
                ? SvgPicture.asset("assets/images/$customIcon.svg")
                : SvgPicture.asset("assets/images/${customIcon}_selected.svg"),
            const SizedBox(
              height: 4,
            ),
            value == groupValue
                ? Text(
                    title.toString(),
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      color: ConstantColors.cardColor,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      fontFamily: localization == "en"
                          ? GoogleFonts.roboto().fontFamily
                          : 'DubaiFont',
                    ),
                  )
                : Text(
                    title.toString(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
          ],
        ),
      ),
    );
  }
}
