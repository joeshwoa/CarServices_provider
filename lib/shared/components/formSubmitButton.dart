

import 'package:autoflex/main.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget FormSubmitButton(
    {String? label,
      dynamic context,
      bool disabled = false,
      required Function onPressed
    } ){
  return Material(
    clipBehavior: Clip.antiAlias,
    shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(50.0) ),
    child: MaterialButton(
      disabledColor: ConstantColors.hintColor,
      onPressed:disabled! ? null: () => onPressed(),

      color: ConstantColors.primaryColor,

      child: Center(child: Padding(
        padding: const EdgeInsets.symmetric(vertical:15.0),
        child: Text(label!,style: TextStyle(color: Colors.white,fontSize: 17,fontWeight: FontWeight.w500,
          fontFamily: localization == "en"
              ? GoogleFonts.roboto().fontFamily
              : 'DubaiFont',),),
      )),),
  );

}