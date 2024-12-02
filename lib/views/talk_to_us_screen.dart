import 'package:autoflex/controllers/support_form_controller.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/select_menu_item.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class TalkToUsScreen extends StatelessWidget {
  TalkToUsScreen({super.key});
  SupportController supportController = Get.put(SupportController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: ConstantColors.backgroundColor,
        leading: Padding(
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
          child: Text('TALK TO US'.tr,
              style: Theme.of(context).textTheme.titleLarge),
        ),
      ),
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Form(
            key: supportController.supportFormKey,
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: ConstantColors.borderColor),
                          borderRadius: BorderRadius.circular(3)),
                      child: ExpansionTile(
                        dense: true,
                        tilePadding: EdgeInsets.symmetric(horizontal: 10),
                        iconColor: ConstantColors.hintColor,
                        collapsedIconColor: ConstantColors.hintColor,
                        initiallyExpanded: false,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text(
                          'Reason of Contact'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: ConstantColors.bodyColor2),
                        ),
                        children: [
                          Column(
                            children: supportController.reasons
                                .map(
                                  (reason) => Padding(
                                    padding: const EdgeInsets.only(
                                        bottom: 8.0, left: 16, right: 16),
                                    child: SelectMenuItem(
                                      value: reason,
                                      title: reason.toUpperCase(),
                                      groupValue: supportController
                                          .selectedReason.value,
                                      onChanged: (value) {
                                        supportController.selectReason(value);
                                        supportController.updateButtonEnable();
                                      },
                                    ),
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    textField(
                        hintStyle: Theme.of(context).textTheme.displaySmall,
                        change: (value) {
                          supportController.updateButtonEnable();
                        },
                        validate: (value) {
                          return Validations.validateName(value!, context);
                        },
                        controller: supportController.nameController,
                        keyboardType: TextInputType.name,
                        isPassword: false,
                        phoneField: false,
                        disabled: false,
                        hint: 'Your Name'.tr,
                        context: context),
                    const SizedBox(
                      height: 8,
                    ),
                    textField(
                        hintStyle: Theme.of(context).textTheme.displaySmall,
                        change: (value) {
                          supportController.updateButtonEnable();
                        },
                        validate: (value) {
                          return Validations.validateEmail(value!, context);
                        },
                        controller: supportController.emailController,
                        keyboardType: TextInputType.emailAddress,
                        isPassword: false,
                        phoneField: false,
                        disabled: false,
                        hint: 'Email Address'.tr,
                        context: context),
                    const SizedBox(
                      height: 8,
                    ),
                    textField(
                        hintStyle: Theme.of(context).textTheme.displaySmall,
                        change: (value) {
                          supportController.updateButtonEnable();
                        },
                        validate: (value) {
                          return Validations.validatePhone(value!, context);
                        },
                        controller: supportController.phoneController,
                        keyboardType: TextInputType.number,
                        isPassword: false,
                        phoneField: true,
                        disabled: false,
                        hint: 'Phone Number'.tr,
                        context: context),
                    const SizedBox(
                      height: 8,
                    ),
                    textField(
                        hintStyle: Theme.of(context).textTheme.displaySmall,
                        change: (value) {
                          supportController.updateButtonEnable();
                        },
                        validate: (value) {
                          return Validations.validateField(value!, context);
                        },
                        controller: supportController.messageController,
                        keyboardType: TextInputType.text,
                        isPassword: false,
                        phoneField: false,
                        disabled: false,
                        expands: true,
                        hint: 'Message'.tr,
                        context: context),
                    const SizedBox(
                      height: 24,
                    ),
                    FormSubmitButton(
                        onPressed: () {
                          supportController.submitTalkToUsMessageRequest();
                        }
                        , disabled: !supportController.buttonEnable.value
                        ,label: 'Submit'.tr
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
