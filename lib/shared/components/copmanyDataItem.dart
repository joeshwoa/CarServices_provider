import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

Widget DataItem(
    {required String title,
    dynamic? prefix,
    dynamic? logo,
    required Function editScreen,
    required Widget description}) {
  return Container(
    margin: EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
        color: ConstantColors.cardColor,
        border: Border.all(color: ConstantColors.borderColor),
        borderRadius: BorderRadius.circular(7)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
               logo ?? prefix,
          SizedBox(width: 16,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 13,
                          color: ConstantColors.hintColor,
                          fontFamily: GoogleFonts.roboto().fontFamily),
                    ),
                    SizedBox(height:12),
                description
                  ],
                ),
              ),
            ],
          ),
        ),
        IconButton(onPressed: () => editScreen(), icon: SvgPicture.asset(edit_gray))
      ],
    ),
  );
}
