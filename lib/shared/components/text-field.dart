import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

Widget textField(
    {dynamic context,
    dynamic keyboardType,
    required Function validate,
    required bool isPassword,
    required bool phoneField,
    Function? change,
    required bool disabled,
    TextEditingController? controller,
    dynamic hintStyle,
    String? hint,
    dynamic? contentPadding,
    dynamic suffix,
    dynamic prefix,
      bool expands = false,
    dynamic? borderColor}) {
  return TextFormField(
    style: Theme.of(context).textTheme.bodyMedium,
    // expands: expands,
    maxLines: expands ? 10 : 1,
    readOnly: disabled,
    cursorColor: ConstantColors.primaryColor,
    controller: controller,
    autovalidateMode: AutovalidateMode.onUserInteraction,
    onChanged: (s) => change!(s),
    validator: (s) => validate(s),
    keyboardType: keyboardType,
    obscureText: isPassword,
    textDirection: phoneField ? TextDirection.ltr : (Get.locale?.languageCode == 'en' ? TextDirection.ltr : TextDirection.rtl),
    decoration: InputDecoration(
        prefixIcon: prefix,
        //  prefixIcon:Padding(padding:prefix!=null? const EdgeInsets.only(left: 16,right: 12
        //  ):contentPadding??const EdgeInsets.symmetric(horizontal: 8,
        //  ),
        //  child:prefix),

        hintStyle: hintStyle,
        hintText: hint,
        counterText: "",
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: const BorderSide(
              color: ConstantColors.borderColor,
              width: 1,
            )),
        isDense: true,
        filled: !disabled,
        fillColor: ConstantColors.cardColor,
        errorMaxLines: 2,
        errorStyle: const TextStyle(
          fontSize: 12.0,
          color: ConstantColors.errorColor,
          // fontWeight: FontWeight.bold,
        ),
        errorBorder: const OutlineInputBorder(
          borderSide:
              BorderSide(color: ConstantColors.errorColor as Color, width: 1),
        ),
        contentPadding: contentPadding ?? const EdgeInsets.all(16),
        prefixIconConstraints: BoxConstraints(maxHeight: 24),
        suffixIcon: suffix,
        // suffixIconConstraints: BoxConstraints(maxHeight: 24),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: borderColor ?? ConstantColors.primaryColor, width: 1.5),
        )),
    // isDense: true,
    // filled: !disabled,
    // fillColor: ConstantColors.cardColor,
    // errorMaxLines: 2,
    // errorStyle: const TextStyle(
    //   fontSize: 12.0,
    //   color: ConstantColors.errorColor,
    //   // fontWeight: FontWeight.bold,
    // ),
    // errorBorder: const OutlineInputBorder(
    //   borderSide:
    //       BorderSide(color: ConstantColors.errorColor as Color, width: 1),
    // ),
    // // contentPadding: EdgeInsets.symmetric(vertical:12,horizontal: 16),

    // prefixIconConstraints: BoxConstraints(maxHeight: 2.9.h),
    // suffixIcon: suffix,
    // prefixIcon: preffix,
    // suffixIconConstraints: BoxConstraints(maxHeight: 5.7.h),
    // focusedBorder: OutlineInputBorder(
    //   borderSide: BorderSide(color: borderColor, width: 1.5),
    // )),
  );
}
