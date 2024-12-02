import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../styles/icons_assets.dart';

Widget sucess({
required String type,
String? orderId,
dynamic context
})
{
  return Padding(
  padding: const EdgeInsets.symmetric(horizontal: 35.0,vertical: 66),
    child: Column(
      children: [
        const SizedBox(height: 66,),
            Align(
                alignment: Alignment.centerRight,
                child: SvgPicture.asset(starsBlue)),
               SvgPicture.asset(success),
               const SizedBox(height: 42,) ,
               type=='phoneVerified'
               ?Column(
                 children: [
                   Text('Your phone number has been'.tr,style:TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff959699),
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                ) ,),
                Text('successfully verified'.tr,style:TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                )),
                 SizedBox(height: 65,),
                FormSubmitButton(label: 'Go to Login'.tr,context:  context,
                                                        onPressed: (){
                                                         Get.offAll(SignInScreen());
                                                        }),
                 ],
               )
               :Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [

                  Text('Thank you for submitting your application. Our team will promptly review it. In the meantime, feel free to proceed with setting up your services.'.tr,
                   overflow: TextOverflow.visible,
                   textAlign: TextAlign.center,
                  style:TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                )),
                SizedBox(height: 16,),
                 Center(
                   child: Text(
'Once your application is approved, your services will be activated on our platform.'.tr,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                   style:TextStyle(
                     
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff959699),
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                                   ) ,),
                 ),
                 SizedBox(height: 16,),
                SizedBox(height: 39,),
                FormSubmitButton(label: 'Continue'.tr,context:  context,
                                                        onPressed: (){
                                                         Get.to(CompanyDetailsScreen());
                                                        }),
               ],)

      ],
    ),
  );
}