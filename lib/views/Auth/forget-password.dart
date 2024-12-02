import 'package:autoflex/controllers/Auth/forget-password-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/validations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/styles/colors.dart';
import '../../shared/styles/icons_assets.dart';


class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({super.key});
  final ForgetPasswordController controller = Get.put(ForgetPasswordController());
  @override
  Widget build(BuildContext context) {
    return Obx(()=>
       Scaffold(
            backgroundColor: ConstantColors.backgroundColor,
            appBar: AppBar(
              
              elevation: 0.0,
              backgroundColor: ConstantColors.backgroundColor,
              leading:   Padding(
                padding: const EdgeInsetsDirectional.only(top: 16.0),
                child: IconButton(
                  icon: Get.locale?.languageCode == 'en'
                      ? SvgPicture.asset(arrowBack)
                      : Transform.rotate(
                    angle: 3.14,
                    child: SvgPicture.asset(arrowBack),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
              
        
              centerTitle: true,
              title: Padding(
               padding: const EdgeInsetsDirectional.only(top: 16.0),
                child: Text('FORGET PASSWORD'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge),
              ),
                                         ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Form(
                        key: controller.forgetPasswordFormKey,
                        child: Column(children: [
                            const SizedBox(
                            height: 32,
                          ),
                          Text('Please enter your register email address, We can help you recover your password.'.tr,
                          overflow: TextOverflow.visible,
                          style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff45464C),
                    fontFamily: localization == "en"
                        ? GoogleFonts.roboto().fontFamily
                        : 'DubaiFont',
                    ),),
                     const SizedBox(
                            height: 24,
                          ),
                          textField(
                             hintStyle: Theme.of(context).textTheme.displaySmall,
                            hint: 'Email Address'.tr,
                            context: context,
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                            isPassword: false,
                            phoneField: false,
                            change: (value) {},
                            validate: (value) {
                              return Validations.validateEmail(value!, context);
                            },
                            disabled: false,
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                             controller.errorMessage.value != ""
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textScaleFactor: 1,
                                      controller.errorMessage.value,
                                      style: const TextStyle(
                                        fontSize: 12.0,
                                        color: ConstantColors.errorColor,
                                        // fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              : SizedBox(),
                                FormSubmitButton(label: 'Submit'.tr,context:  context,
                                                        onPressed: (){
                                                          controller.forgetPasswordRequest();
                                                        }),
                                
                        ]))))),
    );}}