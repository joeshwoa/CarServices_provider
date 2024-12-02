import 'package:autoflex/main.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ForgetPasswordForWorkerDialogCustom extends StatelessWidget {
  const ForgetPasswordForWorkerDialogCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 0, 0, .45),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 36),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: ConstantColors.secondaryColor,
                    size: 40,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Please ask your manger/company owner to change or update your password.'.tr,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: ConstantColors.primaryColor,
                        fontFamily: localization == "en"
                            ? GoogleFonts.roboto().fontFamily
                            : 'DubaiFont'),
                    maxLines: 3,
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Cancel'.tr,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: ConstantColors.secondaryColor,
                        fontFamily: localization == "en"
                            ? GoogleFonts.roboto().fontFamily
                            : 'DubaiFont'),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
