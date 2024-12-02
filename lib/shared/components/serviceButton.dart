import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Home/welcome/chooseLang_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../styles/colors.dart';
import '../styles/icons_assets.dart';
  final  controller = Get.find<CompanyDetailsController>();
Widget createButton(
    {required String label,
    required String prefixIcon,
    required String suffixIcon,
    required Function screen}) {
  return Container(
    padding: const EdgeInsets.only(bottom: 12),
    height: 60,
    child: FractionallySizedBox(
      widthFactor: 1,
      child: OutlinedButton.icon(
        onPressed: () async =>{
          print(label),
          if(label == 'Add Company Logo & Details'.tr || label =='ADD COMPANY LOGO & DETAILS' )
          {screen()}
    else{     await controller.getMeData(),
          if(controller.hasCompany==true){
screen()
          }
          else{
            toast(message: 'you must add company details first'.tr)
          }}
      
        } ,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(ConstantColors.cardColor),
          side: MaterialStateProperty.all(
              const BorderSide(color: ConstantColors.borderColor)),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
        icon: CachedNetworkImage(
            imageUrl: prefixIcon,
            width: 20,
            fit: BoxFit.fitHeight,
            errorWidget: (context, url, error) => SvgPicture.asset(prefixIcon)),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              child: Row(
                children: [
                  const SizedBox(
                      width:
                          8), // Adjust the width for desired space between icon and label
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 11,
                      color: ConstantColors.bodyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Get.locale?.languageCode == 'en'
                ? SvgPicture.asset(
              suffixIcon,)
                : Transform.rotate(
              angle: 3.14,
              child: SvgPicture.asset(
                suffixIcon,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
