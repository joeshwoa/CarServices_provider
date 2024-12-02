import 'package:autoflex/controllers/Auth/sign-up-controller.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/loadingButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';

import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../main.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  final SignUpController controller = Get.put(SignUpController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
              backgroundColor: ConstantColors.backgroundColor,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: ConstantColors.backgroundColor,
                leading: Text(''),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: Text('Create New Account'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge),
                ),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                          key: controller.signUpFormKey,
                          child: Column(children: [
                            const SizedBox(
                              height: 32,
                            ),
                            textField(
                              hintStyle: Theme.of(context).textTheme.displaySmall,
                              hint: 'Your Name'.tr,
                              context: context,
                              keyboardType: TextInputType.name,
                              controller: controller.nameController,
                              isPassword: false,
                              phoneField: false,
                              change: (value) {},
                              validate: (value) {
                                return Validations.validateName(value!, context);
                              },
                              disabled: false,
                            ),
                            const SizedBox(
                              height: 8,
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
                              height: 8,
                            ),
                            textField(
                              hintStyle: Theme.of(context).textTheme.displaySmall,
                              hint: 'Password'.tr,
                              context: context,
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.passwordController,
                              isPassword: !controller.visiblePassword.value,
                              change: (value) {},
                              phoneField: false,
                              validate: (value) {
                                return Validations.validatePassword(
                                    value!, context);
                              },
                              disabled: false,
                              suffix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    controller.visiblePassword.toggle();
                                  },
                                  icon: controller.visiblePassword.value
                                      ? SvgPicture.asset(
                                          visibility,
                                          width: 20,
                                          height: 20,
                                        )
                                      : SvgPicture.asset(visibilityOff),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            textField(
                              hintStyle: Theme.of(context).textTheme.displaySmall,
                              hint: 'Confirm Password'.tr,
                              context: context,
                              keyboardType: TextInputType.visiblePassword,
                              controller: controller.confirmpasswordController,
                              isPassword: !controller.visibleConfirmPassword.value,
                              change: (value) {},
                              phoneField: false,
                              validate: (value) {
                                return Validations.validateconfirmPassword(value!,
                                    context, controller.passwordController.text);
                              },
                              disabled: false,
                              suffix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    controller.visibleConfirmPassword.toggle();
                                  },
                                  icon: controller.visibleConfirmPassword.value
                                      ? SvgPicture.asset(
                                          visibility,
                                          width: 20,
                                          height: 20,
                                        )
                                      : SvgPicture.asset(visibilityOff),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Stack(
                              children: [
                                textField(
                                  hint: 'Phone Number'.tr,
                                  context: context,
                                  keyboardType: TextInputType.phone,
                                  controller: controller.phoneController,
                                  isPassword: false,
                                  phoneField: true,
                                  change: (value) {
                                    controller.isPlaceholderVisible.value = false;
                                    if (!value.startsWith("+971")) {
                                      controller.phoneController.text = "+971";
                                      controller.phoneController.selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset: controller
                                                .phoneController.text.length),
                                      );
                                    }
                                  },
                                  validate: (value) {
                                    return Validations.validatePhone(
                                        value!, context);
                                  },
                                  disabled: false,
                                ),
                                controller.isPlaceholderVisible.value
                                    ? Positioned(
                                        left: 60,
                                        top: 16,
                                        bottom: 16,
                                        child: IgnorePointer(
                                          ignoring: true,
                                          child: Text(
                                            'Phone number'.tr,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            controller.showwhatsApp.value
                                ? Column(
                                    children: [
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Stack(
                                        children: [
                                          textField(
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .displaySmall,
                                            hint: 'Whats App Number'.tr,
                                            context: context,
                                            keyboardType: TextInputType.phone,
                                            controller:
                                                controller.whatsappController,
                                            isPassword: false,
                                            phoneField: true,
                                            change: (value) {
                                              controller
                                                  .iswhatsAppPlaceholderVisible
                                                  .value = false;
                                              if (!value.startsWith("+971")) {
                                                controller.whatsappController.text =
                                                    "+971";
                                                controller.whatsappController
                                                        .selection =
                                                    TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: controller
                                                          .whatsappController
                                                          .text
                                                          .length),
                                                );
                                              }
                                            },
                                            validate: (value) {
                                              return Validations.validatePhone(
                                                  value!, context);
                                            },
                                            disabled: false,
                                          ),
                                          controller.iswhatsAppPlaceholderVisible
                                                  .value
                                              ? Positioned(
                                                  left: 60,
                                                  top: 16,
                                                  bottom: 16,
                                                  child: IgnorePointer(
                                                    ignoring: true,
                                                    child: Text(
                                                      'Whats App Number'.tr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .displaySmall,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(),
                                        ],
                                      )
                                    ],
                                  )
                                : const SizedBox(),
                            const SizedBox(
                              height: 24,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: controller.showwhatsApp.value
                                                ? ConstantColors.secondaryColor
                                                : Color(0xffC8C9CC))),
                                    child: Checkbox(
                                        side: BorderSide(color: Colors.transparent),
                                        focusColor: ConstantColors.secondaryColor,
                                        activeColor: ConstantColors.backgroundColor,
                                        checkColor: ConstantColors.secondaryColor,
                                        value: controller.showwhatsApp.value,
                                        onChanged: (value) {
                                          controller.showwhatsApp.value = value!;
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'Are you using different number for WhatsApp?'.tr,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff717276),
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: localization == "en"
                                            ? GoogleFonts.roboto().fontFamily
                                            : 'DubaiFont'),
                                  )
                                ]),
                            SizedBox(
                              height: 12,
                            ),
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: controller.terms.value
                                                ? ConstantColors.secondaryColor
                                                : Color(0xffC8C9CC))),
                                    child: Checkbox(
                                        side: BorderSide(color: Colors.transparent),
                                        focusColor: ConstantColors.secondaryColor,
                                        activeColor: ConstantColors.backgroundColor,
                                        checkColor: ConstantColors.secondaryColor,
                                        value: controller.terms.value,
                                        onChanged: (value) {
                                          controller.terms.value = value!;
                                        }),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Text(
                                    'I am agree to '.tr,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xff717276),
                                        overflow: TextOverflow.ellipsis,
                                        fontFamily: localization == "en"
                                            ? GoogleFonts.roboto().fontFamily
                                            : 'DubaiFont'),
                                  ),
                                  InkWell(
                                    onTap: () => {},
                                    child: Text(
                                      'Terms & Conditions'.tr,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w700,
                                          color: Color(0xff717276),
                                          overflow: TextOverflow.ellipsis,
                                          fontFamily: localization == "en"
                                              ? GoogleFonts.roboto().fontFamily
                                              : 'DubaiFont'),
                                    ),
                                  )
                                ]),
                            controller.errorMessage.value != ""
                                ? Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.errorMessage.value,
                                        style: const TextStyle(
                                          fontSize: 12.0,
                                          color: ConstantColors.errorColor,
                                          // fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 24.0),
                              child: !controller.loading.value
                                  ? FormSubmitButton(
                                      label: 'Register'.tr,
                                       disabled: !controller.terms.value,
                                      context: context,
                                      onPressed: () {
                                        controller.signUpRequest();
                                      })
                                  : const LoadingButton(),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Already have an account? '.tr,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: localization == "en"
                                        ? GoogleFonts.roboto().fontFamily
                                        : 'DubaiFont',
                                  ),
                                ),
                                TextButton(
                                  onPressed: () => Get.to(() => SignInScreen()),
                                  child: Text('Login'.tr,
                                      style: TextStyle(
                                        color: ConstantColors.secondaryColor,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700,
                                        fontFamily: localization == "en"
                                            ? GoogleFonts.roboto().fontFamily
                                            : 'DubaiFont',
                                      )),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            )
                          ]))))),
        controller.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }
}
