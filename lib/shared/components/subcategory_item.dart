import 'dart:developer';

import 'package:autoflex/controllers/Company_data/services/subcategory_controller.dart';
import 'package:autoflex/shared/components/disable_pop-up.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'serviceRateItem.dart';

Widget subCategory(
    {required String title,
    dynamic context,
    required int id,
    required String type,
    List? serviceRates}) {
  var itemSelected = true.obs;
  final SubCategoryController controller = Get.find<SubCategoryController>();
  return Obx(
    () {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: ConstantColors.cardColor,
            border: Border.all(color: ConstantColors.borderColor),
            borderRadius: BorderRadius.circular(7)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: itemSelected.value
                              ? ConstantColors.secondaryColor
                              : const Color(0xffC8C9CC))),
                  child: Checkbox(
                      side: BorderSide(color: Colors.transparent),
                      focusColor: ConstantColors.secondaryColor,
                      activeColor: ConstantColors.backgroundColor,
                      checkColor: ConstantColors.secondaryColor,
                      value: controller.service.value.id != null
                          ? itemSelected.value
                          : true,
                      onChanged: (value) {
                        if (!value!) {
                          if (controller.service.value.id != null) {
                            Get.dialog(
                              const DisablePopUp(),
                            ).then((result) {
                              if (result == true) {
                                itemSelected.value = false;
                                controller.aboutToDisable.value = true;
                              }
                            });
                          } else {
                            itemSelected.value = !itemSelected.value;
                          }
                        } else {
                          itemSelected.value = true;
                          controller.aboutToDisable.value = false;
                        }
                      }),
                ),
                const SizedBox(
                  width: 12,
                ),
                Text(
                  title,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ],
            ),
            itemSelected.value
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 1,
                        color: ConstantColors.borderColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Service Rates'.tr,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                          children: serviceRates!
                              .map((serviceRate) =>
                                  // Text(serviceRate['type'].toString())
                                  ServiceRateItem(
                                      context: context,
                                      type: serviceRate.name,
                                      id: serviceRate.id,
                                      description:
                                          'Also coupe, sport mini or similar'.tr))
                              .toList()),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        height: 1,
                        color: ConstantColors.borderColor,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Service Description & Highlights'.tr,
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          SvgPicture.asset(help)
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Form(
                        key: controller.subCategoryFormKey,
                        child: Column(
                          children: [
                            Column(
                              children: List.generate(
                                controller.descriptionLength.value,
                                (index) => Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: textField(
                                      controller: controller
                                          .descriptionControllers[index],
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 8),
                                      validate: (value) {
                                        return Validations.validateRequired(
                                            value!, context);
                                      },
                                      context: context,
                                      isPassword: false,
                                      phoneField: false,
                                      disabled: false,
                                      prefix: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.only(
                                                start: 4.0, end: 8),
                                        child: SvgPicture.asset(greenCheck),
                                      ),
                                      hint: 'Enter description/highlight'.tr,
                                      hintStyle: TextStyle(
                                          fontSize: 9,
                                          color: Color(0xFF717276),
                                          fontWeight: FontWeight.w400,
                                          fontFamily:
                                              GoogleFonts.roboto().fontFamily)),
                                ),
                              ),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: TextButton.icon(
                                  onPressed: () {
                                    controller.addField('description');
                                  },
                                  icon: SvgPicture.asset(add),
                                  label: Text(
                                    'Add More Points'.tr,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: ConstantColors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              height: 1,
                              color: ConstantColors.borderColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Additional Information'.tr,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SvgPicture.asset(help)
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: List.generate(
                                  controller.informationLength.value,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: textField(
                                            controller: controller
                                                .informationControllers[index],
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                    horizontal: 8),
                                            validate: (value) {
                                              return Validations
                                                  .validateRequired(
                                                      value!, context);
                                            },
                                            context: context,
                                            isPassword: false,
                                            phoneField: false,
                                            disabled: false,
                                            prefix: Padding(
                                              padding:
                                                  const EdgeInsetsDirectional
                                                      .only(start: 4.0, end: 8),
                                              child: SvgPicture.asset(moreIcon),
                                            ),
                                            hint: 'Enter description '.tr,
                                            hintStyle: TextStyle(
                                                fontSize: 9,
                                                color: Color(0xFF717276),
                                                fontWeight: FontWeight.w400,
                                                fontFamily: GoogleFonts.roboto()
                                                    .fontFamily)),
                                      )),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: TextButton.icon(
                                  onPressed: () {
                                    controller.addField('information');
                                  },
                                  icon: SvgPicture.asset(add),
                                  label: Text(
                                    'Add More Points'.tr,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: ConstantColors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              height: 1,
                              color: ConstantColors.borderColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Add-ons Product / Extra Service'.tr,
                                  style: Theme.of(context).textTheme.labelLarge,
                                ),
                                SvgPicture.asset(help)
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Column(
                              children: List.generate(
                                  controller.addonsLength.value,
                                  (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 12),
                                        child: Column(
                                          children: [
                                            Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      width: 17,
                                                      child: SvgPicture.asset(
                                                          greenAdd)),
                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  Expanded(
                                                    child: textField(
                                                        controller: controller
                                                            .addonsControllers[
                                                                index]
                                                            .name
                                                            .value,
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 12,
                                                                horizontal: 8),
                                                        validate: (value) {
                                                          return Validations
                                                              .validateRequired(
                                                                  value!,
                                                                  context);
                                                        },
                                                        context: context,
                                                        isPassword: false,
                                                        phoneField: false,
                                                        disabled: false,
                                                        hint:
                                                            'Name of add-on product / extra service '.tr,
                                                        hintStyle: TextStyle(
                                                            fontSize: 9,
                                                            color: Color(
                                                                0xFF717276),
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: GoogleFonts
                                                                    .roboto()
                                                                .fontFamily)),
                                                  ),
                                                ]),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Expanded(
                                                  child: textField(
                                                      controller: controller
                                                          .addonsControllers[
                                                              index]
                                                          .description
                                                          .value,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 12,
                                                              horizontal: 8),
                                                      validate: (value) {
                                                        return Validations
                                                            .validateRequired(
                                                                value!,
                                                                context);
                                                      },
                                                      context: context,
                                                      isPassword: false,
                                                      phoneField: false,
                                                      disabled: false,
                                                      hint: 'Enter description'.tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              Color(0xFF717276),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily)),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 25,
                                                ),
                                                Column(
                                                  children: [
                                                    Text('Price (AED)'.tr,
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color:
                                                                ConstantColors
                                                                    .bodyColor3,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    Text('Including VAT'.tr,
                                                        style: TextStyle(
                                                            fontSize: 7,
                                                            color:
                                                                ConstantColors
                                                                    .bodyColor,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Expanded(
                                                  child: textField(
                                                      controller: controller
                                                          .addonsControllers[
                                                              index]
                                                          .price
                                                          .value,
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 12,
                                                              horizontal: 8),
                                                      validate: (value) {
                                                        return Validations
                                                            .validatePrice(
                                                                value!,
                                                                context);
                                                      },
                                                      context: context,
                                                      isPassword: false,
                                                      phoneField: false,
                                                      disabled: false,
                                                      hint: 'Price'.tr,
                                                      hintStyle: TextStyle(
                                                          fontSize: 9,
                                                          color:
                                                              Color(0xFF717276),
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontFamily:
                                                              GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily)),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Container(
                                                  width: 24,
                                                  height: 24,
                                                  child: FittedBox(
                                                    fit: BoxFit.fill,
                                                    child: Switch(
                                                      value: controller
                                                          .addonsControllers[
                                                              index]
                                                          .multiQty
                                                          .value,
                                                      onChanged: (value) {
                                                        controller
                                                                .addonsControllers[
                                                                    index]
                                                                .multiQty
                                                                .value =
                                                            !controller
                                                                .addonsControllers[
                                                                    index]
                                                                .multiQty
                                                                .value;
                                                        controller
                                                            .addonsControllers
                                                            .refresh();
                                                      },
                                                      activeColor:
                                                          ConstantColors
                                                              .secondaryColor,
                                                      inactiveThumbColor:
                                                          ConstantColors
                                                              .bodyColor,
                                                      activeTrackColor:
                                                          ConstantColors
                                                              .cardColor,
                                                      inactiveTrackColor:
                                                          ConstantColors
                                                              .cardColor,
                                                      trackOutlineColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color?>((Set<
                                                                      MaterialState>
                                                                  states) {
                                                        if (controller
                                                            .addonsControllers[
                                                                index]
                                                            .multiQty
                                                            .value) {
                                                          return ConstantColors
                                                              .secondaryColor;
                                                        }
                                                        return ConstantColors
                                                            .bodyColor; // Use the default color.
                                                      }),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 8,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text('Multi Quantity'.tr,
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color:
                                                                ConstantColors
                                                                    .bodyColor3,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400)),
                                                    Text(
                                                        'Can client add multiple quantities?'.tr,
                                                        style: TextStyle(
                                                            fontSize: 7,
                                                            color:
                                                                ConstantColors
                                                                    .bodyColor,
                                                            fontFamily:
                                                                GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )),
                            ),
                            Align(
                              alignment: AlignmentDirectional.topEnd,
                              child: TextButton.icon(
                                  onPressed: () {
                                    controller.addField('addon');
                                  },
                                  icon: SvgPicture.asset(add),
                                  label: Text(
                                    'Add More Add-ons'.tr,
                                    style: TextStyle(
                                        fontSize: 9,
                                        color: ConstantColors.secondaryColor,
                                        fontWeight: FontWeight.bold),
                                  )),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Divider(
                              height: 1,
                              color: ConstantColors.borderColor,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Service Duration & Additional Requirements'.tr,
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            textField(
                                controller:
                                    controller.serviceDurationController.value,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 12, horizontal: 8),
                                validate: (value) {
                                  return Validations.validateHours(
                                      value!, context);
                                },
                                context: context,
                                isPassword: false,
                                phoneField: false,
                                disabled: false,
                                prefix: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 4.0, end: 8),
                                  child: SvgPicture.asset(acute),
                                ),
                                hint: 'HH:MM'.tr,
                                hintStyle: TextStyle(
                                    fontSize: 9,
                                    color: Color(0xFF717276),
                                    fontWeight: FontWeight.w400,
                                    fontFamily:
                                        GoogleFonts.roboto().fontFamily)),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  child: FittedBox(
                                    fit: BoxFit.fill,
                                    child: Switch(
                                      value: controller.power.value,
                                      onChanged: (value) => {
                                        controller.power.value =
                                            !controller.power.value
                                      },
                                      activeColor: ConstantColors.errorColor,
                                      inactiveThumbColor:
                                          ConstantColors.bodyColor,
                                      activeTrackColor:
                                          ConstantColors.cardColor,
                                      inactiveTrackColor:
                                          ConstantColors.cardColor,
                                      trackOutlineColor: MaterialStateProperty
                                          .resolveWith<Color?>(
                                              (Set<MaterialState> states) {
                                        if (controller.power.value) {
                                          return ConstantColors.errorColor;
                                        }
                                        return ConstantColors
                                            .bodyColor; // Use the default color.
                                      }),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Power outlet is required ?'.tr,
                                        style: TextStyle(
                                            fontSize: 9,
                                            color: ConstantColors.bodyColor3,
                                            fontFamily:
                                                GoogleFonts.roboto().fontFamily,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                        'Enable this option if you need power outlet to operate your service equipment.'.tr,
                                        style: TextStyle(
                                            fontSize: 7,
                                            color: ConstantColors.bodyColor,
                                            fontFamily:
                                                GoogleFonts.roboto().fontFamily,
                                            fontWeight: FontWeight.w400))
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : SizedBox(),
          ],
        ),
      );
    },
  );
}
