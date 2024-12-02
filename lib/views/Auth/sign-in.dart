import 'package:autoflex/controllers/Auth/sign-in-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/shared/components/forgetPasswordForWorkerDialogCustom.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/loadingButton.dart';
import 'package:autoflex/shared/components/select_menu_item.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';

import 'package:autoflex/views/Auth/forget-password.dart';
import 'package:autoflex/views/Auth/sign-up.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../../shared/components/select_date.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});
  final SignInController controller = Get.put(SignInController());
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () async {
                        if (sharedPreferenceController.localization.value ==
                            'en') {
                          Get.updateLocale(Locale('ar'));
                          sharedPreferenceController.localization.value = 'ar';
                          await sharedPreferenceController.setValue(
                              'localization', 'ar');
                        } else {
                          Get.updateLocale(Locale('en'));
                          sharedPreferenceController.localization.value = 'en';
                          await sharedPreferenceController.setValue(
                              'localization', 'en');
                        }

                        await Restart.restartApp();
                      },
                      child: Row(
                        children: [
                          Text(
                            'العربية',
                            style: TextStyle(
                                fontSize: 11,
                                color: ConstantColors.primaryColor,
                                fontFamily: localization == "en"
                                    ? GoogleFonts.roboto().fontFamily
                                    : 'DubaiFont',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(language),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: controller.signInFormKey,
                        child: Column(children: [
                          Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 64.0),
                              child: SvgPicture.asset(logo2),
                            ),
                          ),
                          Center(
                            child: Text('SIGN IN'.tr,
                                style: Theme.of(context).textTheme.titleLarge),
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: ConstantColors.primaryColor,
                                borderRadius: BorderRadius.circular(3)),
                            child: ExpansionTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              collapsedShape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3.0)),
                              iconColor: ConstantColors.cardColor,
                              textColor: ConstantColors.cardColor,
                              collapsedTextColor: ConstantColors.cardColor,
                              collapsedIconColor: ConstantColors.cardColor,
                              initiallyExpanded: false,
                              onExpansionChanged: (value) =>
                                  controller.isExpanded.value = value,
                              maintainState: controller.isExpanded.value,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              title: Text(
                                controller.selectedRole.value,
                                // style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              children: [
                                Container(
                                  color: ConstantColors.cardColor,
                                  padding: EdgeInsets.only(bottom: 8, top: 16),
                                  child: Column(
                                    children: controller.roles
                                        .map(
                                          (emirate) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0,
                                                left: 16,
                                                right: 16),
                                            child: SelectMenuItem(
                                              value: emirate,
                                              title: emirate.toUpperCase(),
                                              groupValue:
                                                  controller.selectedRole.value,
                                              onChanged: (value) {
                                                controller.selectRole(value!);
                                              },
                                            ),
                                          ),
                                        )
                                        .toList(),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (controller.selectedRole.value != 'Worker'.tr)
                            textField(
                              hintStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              hint: 'Email Address'.tr,
                              context: context,
                              keyboardType: TextInputType.emailAddress,
                              controller: controller.emailController,
                              isPassword: false,
                              phoneField: false,
                              change: (value) {},
                              validate: (value) {
                                return Validations.validateEmail(
                                    value!, context);
                              },
                              disabled: false,
                            ),
                          if (controller.selectedRole.value == 'Worker'.tr)
                            textField(
                              hintStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              hint: 'User Name'.tr,
                              context: context,
                              keyboardType: TextInputType.name,
                              controller: controller.emailController,
                              isPassword: false,
                              phoneField: false,
                              change: (value) {},
                              validate: (value) {
                                return Validations.validateName(
                                    value!, context);
                              },
                              disabled: false,
                            ),
                          const SizedBox(
                            height: 8,
                          ),
                          textField(
                            hintStyle: Theme.of(context).textTheme.displaySmall,
                            hint: 'Password'.tr,
                            phoneField: false,
                            context: context,
                            keyboardType: TextInputType.visiblePassword,
                            controller: controller.passwordController,
                            isPassword: !controller.visiblePassword.value,
                            change: (value) {},
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
                          Align(
                              alignment: Alignment.topRight,
                              child: TextButton(
                                  onPressed: () {
                                    if (controller.selectedRole.value ==
                                        'Worker'.tr) {
                                      Get.dialog(
                                          ForgetPasswordForWorkerDialogCustom());
                                    } else {
                                      Get.to(() => ForgetPasswordScreen());
                                    }
                                  },
                                  child: Text(
                                    'Forget Password?'.tr,
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w700,
                                        color: ConstantColors.primaryColor,
                                        fontFamily: localization == "en"
                                            ? GoogleFonts.roboto().fontFamily
                                            : 'DubaiFont'),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 0),
                            child: !controller.loading.value
                                ? FormSubmitButton(
                                    label: 'Login'.tr,
                                    context: context,
                                    onPressed: () {
                                      controller.loginRequest();
                                    })
                                : const LoadingButton(),
                          ),
                          const SizedBox(
                            height: 44,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don’t have an account?'.tr,
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
                                onPressed: () => Get.to(() => SignUpScreen()),
                                child: Text('Register'.tr,
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
                        ]),
                      )))),
          controller.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }
}
