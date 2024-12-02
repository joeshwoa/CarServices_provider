import 'dart:developer';
import 'dart:ffi';

import 'package:autoflex/controllers/Company_data/bussines%20hours/manage_hours_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/models/bussiness%20hours/workdays.dart';
import 'package:autoflex/shared/components/custom_checkbox.dart';
import 'package:autoflex/shared/components/custom_switch.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/shared/workingHoursValidations.dart';
import 'package:autoflex/views/Company_data/bussines%20hours/block_days.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ManageHoursScreen extends StatelessWidget {
  ManageHoursScreen({super.key});
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();

  final ManageHoursController controller = Get.put(ManageHoursController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            'Manage Business Hours'.tr.toUpperCase(),
            style: const TextStyle(
              color: ConstantColors.primaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.17,
            ),
          ),
          leading: IconButton(
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: controller.loading.value
                ? Column(
                    children: [
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          height: 70,
                          width: double.infinity,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white),
                          height: 350,
                          width: double.infinity,
                        ),
                      )
                    ],
                  )
                : Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        height: 70,
                        child: FractionallySizedBox(
                          widthFactor: 1,
                          child: OutlinedButton.icon(
                            onPressed: () {
                              Get.to(() => BlockWorkDaysScreen());
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  ConstantColors.cardColor),
                              side: MaterialStateProperty.all(
                                const BorderSide(
                                    color: ConstantColors.borderColor),
                              ),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                            icon: SvgPicture.asset(calendarBlock),
                            label: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 8,
                                      ), // Adjust the width for desired space between icon and label
                                      Text(
                                        'Block non-operational days'.tr,
                                        style: TextStyle(
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
                                  navigateNext,)
                                    : Transform.rotate(
                                  angle: 3.14,
                                  child: SvgPicture.asset(
                                    navigateNext,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          color: ConstantColors.cardColor,
                          border: Border.all(color: ConstantColors.borderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        foregroundDecoration: BoxDecoration(
                          border: Border.all(color: ConstantColors.borderColor),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: ExpansionPanelList(
                          dividerColor:
                              const Color.fromARGB(255, 238, 239, 241),
                          elevation: 1,
                          expandedHeaderPadding: EdgeInsets.zero,
                          expansionCallback: (int index, bool isExpanded) {
                            controller.isExpanded[index].value =
                                !controller.isExpanded[index].value;
                          },
                          children: controller.weekdays
                              .map<ExpansionPanel>((String day) {
                            int index = controller.weekdays.indexOf(day);
                            if (controller.workingHours[index].allDay != null) {
                              if ((controller.workingHours[index].allDay! &&
                                      controller.workingHours[index].from ==
                                          null) ||
                                  (!controller.workingHours[index].allDay! &&
                                          controller.workingHours[index].from !=
                                              null) &&
                                      !controller.isPopulated[index].value) {
                                controller.populateDay(index);
                              }
                            }
                            return ExpansionPanel(
                              backgroundColor: ConstantColors.cardColor,
                              // hasIcon: false,
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(start: 12),
                                      child: Obx(() => CustomCheckbox(
                                            value: controller
                                                .isChecked[index].value,
                                            index: index,
                                            onChanged: (index) {
                                              controller
                                                      .isChecked[index].value =
                                                  !controller
                                                      .isChecked[index].value;
                                              if (controller
                                                  .isChecked[index].value) {
                                                controller.addDay(index);
                                              } else {
                                                controller.removeDay(index);
                                              }
                                            },
                                          )),
                                    ), // Use the custom checkbox
                                    Expanded(
                                      child: ListTile(
                                        title: Text(
                                          day,
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelSmall!
                                              .copyWith(
                                                  color:
                                                      ConstantColors.bodyColor),
                                        ),
                                      ),
                                    ),
                                    Transform.scale(
                                      scale: 1.4,
                                      child: CustomSwitch(
                                        value:
                                            controller.isSwitched[index].value,
                                        onChanged: (bool value) {
                                          controller.isSwitched[index].value =
                                              value;
                                          controller.workingHours[index]
                                              .allDay = value;
                                          if (value) {
                                            controller.controllers[index][0]
                                                .value.text = '';
                                            controller.workingHours[index]
                                                .from = null;
                                            controller.controllers[index][1]
                                                .value.text = '';
                                            controller.workingHours[index].to =
                                                null;
                                          }
                                        },
                                      ),
                                    ),
                                    Text(
                                      'Opens 24 hours?'.tr,
                                      style: TextStyle(
                                        color: Color(0xFF292B33),
                                        fontSize: 9,
                                        fontFamily: 'Roboto',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                        letterSpacing: -0.09,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    )
                                  ],
                                );
                              },
                              body: Form(
                                key: controller.workingHoursFormKeys[index],
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16),
                                    child: Column(
                                      children: [
                                        const Divider(
                                          height: 1,
                                          color: ConstantColors.borderColor,
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  end: 8),
                                              child: Text('Opening Time'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                            ),
                                            Expanded(
                                              child: textField(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                borderColor: ConstantColors
                                                    .secondaryColor,
                                                prefix: Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 8),
                                                    child: Transform.scale(
                                                      scale: 1.25,
                                                      child: SvgPicture.asset(
                                                          time),
                                                    )),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                                hint: 'HH:MM'.tr,
                                                context: context,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: controller
                                                    .controllers[index][0]
                                                    .value,
                                                isPassword: false,
                                                phoneField: false,
                                                change: (value) {
                                                  controller.workingHours[index]
                                                          .from =
                                                      controller
                                                          .controllers[index][0]
                                                          .value
                                                          .text;
                                                },
                                                validate: (value) {
                                                  return WorkingHoursValidations
                                                      .validateWorkingHours(
                                                    value,
                                                    context,
                                                    index,
                                                    controller.isSwitched[index]
                                                        .value,
                                                  );
                                                },
                                                disabled: controller
                                                    .isSwitched[index].value,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding: const EdgeInsetsDirectional.only(
                                                  end: 12),
                                              child: Text('Closing Time'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelLarge),
                                            ),
                                            Expanded(
                                              child: textField(
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                borderColor: ConstantColors
                                                    .secondaryColor,
                                                prefix: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Transform.scale(
                                                    scale: 1.25,
                                                    child:
                                                        SvgPicture.asset(time),
                                                  ),
                                                ),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
                                                hint: 'HH:MM'.tr,
                                                context: context,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: controller
                                                    .controllers[index][1]
                                                    .value,
                                                isPassword: false,
                                                phoneField: false,
                                                change: (value) {
                                                  controller.workingHours[index]
                                                          .to =
                                                      controller
                                                          .controllers[index][1]
                                                          .value
                                                          .text;
                                                },
                                                validate: (value) {
                                                  return WorkingHoursValidations
                                                      .validateWorkingHours(
                                                    value,
                                                    context,
                                                    index,
                                                    controller.isSwitched[index]
                                                        .value,
                                                  );
                                                },
                                                disabled: controller
                                                    .isSwitched[index].value,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Transform.scale(
                                              scale: 1.4,
                                              child: CustomSwitch(
                                                value: controller
                                                    .hasBreak[index].value,
                                                onChanged: (bool value) {
                                                  controller.hasBreak[index]
                                                      .value = value;
                                                  controller.workingHours[index]
                                                      .datumBreak = value;
                                                  if (!value) {
                                                    controller
                                                        .controllers[index][2]
                                                        .value
                                                        .text = '';
                                                    controller
                                                        .workingHours[index]
                                                        .breakFrom = null;
                                                    controller
                                                        .controllers[index][3]
                                                        .value
                                                        .text = '';
                                                    controller
                                                        .workingHours[index]
                                                        .breakTo = null;
                                                  }
                                                },
                                              ),
                                            ),
                                            const SizedBox(
                                                width:
                                                    8), // Add some spacing between the switch and the text
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                EdgeInsetsDirectional.only(end: 8),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Do you have a break?'.tr,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF292B33),
                                                          fontSize: 9,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height:
                                                              1, // Adjust the height as needed
                                                          letterSpacing: -0.09,
                                                          overflow: TextOverflow
                                                              .visible),
                                                    ),
                                                    SizedBox(
                                                        height:
                                                            4), // Add some spacing between the two text widgets
                                                    Text(
                                                      'Add the break time so in this time our system will not accept orders for your services. '.tr,
                                                      style: TextStyle(
                                                          color:
                                                              Color(0xFF959699),
                                                          fontSize: 7,
                                                          fontFamily: 'Roboto',
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          height:
                                                              1, // Adjust the height as needed
                                                          letterSpacing: -0.07,
                                                          overflow: TextOverflow
                                                              .visible),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 54,
                                              child: textField(
                                                borderColor: ConstantColors
                                                    .secondaryColor,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 8),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(fontSize: 11),
                                                hint: 'HH:MM'.tr,
                                                context: context,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: controller
                                                    .controllers[index][2]
                                                    .value,
                                                isPassword: false,
                                                phoneField: false,
                                                change: (value) {
                                                  controller.workingHours[index]
                                                          .breakFrom =
                                                      controller
                                                          .controllers[index][2]
                                                          .value
                                                          .text;
                                                },
                                                validate: (value) {
                                                  return WorkingHoursValidations
                                                      .validateBreakHours(
                                                          value,
                                                          context,
                                                          index,
                                                          controller
                                                              .hasBreak[index]
                                                              .value);
                                                },
                                                disabled: !controller
                                                    .hasBreak[index].value,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            SizedBox(
                                              width: 54,
                                              child: textField(
                                                borderColor: ConstantColors
                                                    .secondaryColor,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 8),
                                                hintStyle: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall!
                                                    .copyWith(fontSize: 11),
                                                hint: 'HH:MM'.tr,
                                                context: context,
                                                keyboardType:
                                                    TextInputType.emailAddress,
                                                controller: controller
                                                    .controllers[index][3]
                                                    .value,
                                                isPassword: false,
                                                phoneField: false,
                                                change: (value) {
                                                  controller.workingHours[index]
                                                          .breakTo =
                                                      controller
                                                          .controllers[index][3]
                                                          .value
                                                          .text;
                                                },
                                                validate: (value) {
                                                  return WorkingHoursValidations
                                                      .validateBreakHours(
                                                          value,
                                                          context,
                                                          index,
                                                          controller
                                                              .hasBreak[index]
                                                              .value);
                                                },
                                                disabled: !controller
                                                    .hasBreak[index].value,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    )),
                              ),
                              isExpanded: controller.isExpanded[index].value,
                              canTapOnHeader: true,
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FormSubmitButton(
                          onPressed: () async {
                            await controller.updateWorkingHours();
                            Get.back();
                            await companyDetailsController.getWorkingHours();
                          },
                          label: 'Save'.tr)
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
