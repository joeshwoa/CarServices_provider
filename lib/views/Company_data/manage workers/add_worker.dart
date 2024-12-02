import 'dart:ffi';

import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/company%20workers/edit_company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/company%20workers/worker_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/shared/components/custom_checkbox.dart';
import 'package:autoflex/shared/components/delete_pop-up.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AddWorkerScreen extends StatelessWidget {
  int index;
  bool enabled;
  AddWorkerScreen({
    super.key,
    this.index = -1,
    this.enabled = true,
  }) {
    workerController =
        Get.put(EditCompanyWorkersController(workerIndex: index));
  }
  /* WorkerController workerController = Get.put(WorkerController()); */
  late final EditCompanyWorkersController workerController;

  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();

  bool first = true;
  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                centerTitle: true,
                elevation: 0.0,
                backgroundColor: ConstantColors.backgroundColor,
                title: Text(
                  'add new worker'.tr.toUpperCase(),
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
                child: Obx(() {
                  if (Get.arguments != null &&
                      (Get.arguments as Map).containsKey('type') &&
                      Get.arguments['type'] == 'edit' &&
                      !workerController.populated.value &&
                      index != -1 &&
                      first) {
                    first = false;
                    workerController.workerNameController.value.text =
                        workerController.controller.workers[index].fullName ??
                            '';
                    workerController.workerPhoneNumberController.value.text =
                        workerController.controller.workers[index].phone ?? '';
                    workerController.workerTitleController.value.text =
                        workerController.controller.workers[index].title ?? '';
                    workerController.workerWhatssappNumberController.value
                        .text = workerController
                            .controller.workers[index].whatsappNumber ??
                        '';
                    workerController.workerUserName.value.text =
                        (workerController.controller.workers[index].username ??
                                '')
                            .split('_')
                            .last;
                    if (workerController
                            .workerPhoneNumberController.value.text !=
                        workerController
                            .workerWhatssappNumberController.value.text) {
                      workerController.toggleWhatsApp();
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Form(
                      key: workerController.companyWorkerFormKey,
                      child: Column(
                        children: [
                          textField(
                            hintStyle: Theme.of(context).textTheme.displaySmall,
                            hint: 'Worker Name'.tr,
                            context: context,
                            keyboardType: TextInputType.name,
                            controller:
                                workerController.workerNameController.value,
                            isPassword: false,
                            phoneField: false,
                            change: (value) {},
                            validate: (value) {
                              return Validations.validateName(value!, context);
                            },
                            disabled: !enabled,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textField(
                            hintStyle: Theme.of(context).textTheme.displaySmall,
                            hint: 'Title'.tr,
                            context: context,
                            keyboardType: TextInputType.name,
                            controller:
                                workerController.workerTitleController.value,
                            isPassword: false,
                            phoneField: false,
                            change: (value) {},
                            validate: (value) {
                              return Validations.validateName(value!, context);
                            },
                            disabled: !enabled,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          textField(
                            hint: 'Phone Number'.tr,
                            context: context,
                            keyboardType: TextInputType.phone,
                            controller: workerController
                                .workerPhoneNumberController.value,
                            isPassword: false,
                            phoneField: true,
                            change: (value) {
                              workerController.isPlaceholderVisible.value =
                                  false;
                              if (!value.startsWith("+971")) {
                                workerController.workerPhoneNumberController
                                    .value.text = "+971";
                                workerController
                                    .workerPhoneNumberController
                                    .value
                                    .selection = TextSelection.fromPosition(
                                  TextPosition(
                                      offset: workerController
                                          .workerPhoneNumberController
                                          .value
                                          .text
                                          .length),
                                );
                              }

                              if (!workerController.showwhatsApp.value) {
                                workerController.workerWhatssappNumberController
                                        .value.text =
                                    workerController
                                        .workerPhoneNumberController.value.text;
                              }
                            },
                            validate: (value) {
                              return Validations.validatePhone(value!, context);
                            },
                            disabled: !enabled,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          workerController.showwhatsApp.value
                              ? textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'Whats App Number'.tr,
                                  context: context,
                                  keyboardType: TextInputType.phone,
                                  controller: workerController
                                      .workerWhatssappNumberController.value,
                                  isPassword: false,
                                  phoneField: true,
                                  change: (value) {
                                    workerController
                                        .iswhatsAppPlaceholderVisible
                                        .value = false;
                                    if (!value.startsWith("+971")) {
                                      workerController
                                          .workerWhatssappNumberController
                                          .value
                                          .text = "+971";
                                      workerController
                                              .workerWhatssappNumberController
                                              .value
                                              .selection =
                                          TextSelection.fromPosition(
                                        TextPosition(
                                            offset: workerController
                                                .workerWhatssappNumberController
                                                .value
                                                .text
                                                .length),
                                      );
                                    }
                                  },
                                  validate: (value) {
                                    return Validations.validatePhone(
                                        value!, context);
                                  },
                                  disabled: !enabled,
                                )
                              : const SizedBox(),
                          workerController.showwhatsApp.value
                              ? const SizedBox(
                                  height: 8,
                                )
                              : const SizedBox(),
                          if (enabled)
                            Row(
                              children: [
                                CustomCheckbox(
                                    value: workerController.showwhatsApp.value,
                                    index: 0,
                                    onChanged: (index) {
                                      workerController.toggleWhatsApp();
                                    }),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Different WhatsApp Number?'.tr,
                                  style: TextStyle(
                                    color: Color(0xFF717276),
                                    fontSize: 13,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.13,
                                  ),
                                )
                              ],
                            ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            height: 1,
                            color: ConstantColors.secondaryColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Expertise'.tr,
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Wrap(
                            runSpacing: 8,
                            spacing: 8,
                            children: List.generate(
                                workerController.expertise.length,
                                (index) => Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CustomCheckbox(
                                            value: workerController
                                                .isExpert[index],
                                            index: index,
                                            onChanged: (index) {
                                              if (enabled) {
                                                workerController
                                                    .toggleExperince(index);
                                              }
                                            }),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          workerController.expertise[index]!,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        )
                                      ],
                                    )),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          const Divider(
                            height: 1,
                            color: ConstantColors.secondaryColor,
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            children: [
                              Text(
                                companyDetailsController.company.value.name !=
                                        null
                                    ? '${companyDetailsController.company.value.name}__'
                                    : 'CompanyName__'.tr,
                                style: TextStyle(
                                  color: Color(0xFF002F6C),
                                  fontSize: 15,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: -0.15,
                                ),
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: textField(
                                  hintStyle:
                                      Theme.of(context).textTheme.displaySmall,
                                  hint: 'User Name'.tr,
                                  context: context,
                                  keyboardType: TextInputType.name,
                                  controller:
                                      workerController.workerUserName.value,
                                  isPassword: false,
                                  phoneField: false,
                                  change: (value) {},
                                  validate: (value) {
                                    return Validations.validateName(
                                        value!, context);
                                  },
                                  disabled: !enabled,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          if (Get.arguments['type'] == 'edit' && enabled)
                            Row(
                              children: [
                                CustomCheckbox(
                                    value:
                                        workerController.changePassword.value,
                                    index: 0,
                                    onChanged: (index) {
                                      workerController.togglePassword();
                                    }),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Different Password?'.tr,
                                  style: TextStyle(
                                    color: Color(0xFF717276),
                                    fontSize: 13,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400,
                                    height: 0,
                                    letterSpacing: -0.13,
                                  ),
                                )
                              ],
                            ),
                          if ((Get.arguments['type'] == 'edit' &&
                                  workerController.changePassword.value &&
                                  enabled) ||
                              Get.arguments['type'] != 'edit')
                            textField(
                              hintStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              hint: 'Password'.tr,
                              context: context,
                              keyboardType: TextInputType.visiblePassword,
                              controller: workerController.workerPassword.value,
                              isPassword:
                                  !workerController.visiblePassword.value,
                              change: (value) {},
                              validate: (value) {
                                return Validations.validatePassword(
                                    value!, context);
                              },
                              disabled: false,
                              phoneField: false,
                              suffix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    workerController.visiblePassword.toggle();
                                  },
                                  icon: workerController.visiblePassword.value
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
                          if ((Get.arguments['type'] == 'edit' &&
                                  workerController.changePassword.value &&
                                  enabled) ||
                              Get.arguments['type'] != 'edit')
                            textField(
                              hintStyle:
                                  Theme.of(context).textTheme.displaySmall,
                              hint: 'Confirm Password'.tr,
                              context: context,
                              keyboardType: TextInputType.visiblePassword,
                              controller:
                                  workerController.workerConfirmPassword.value,
                              isPassword: !workerController
                                  .visibleConfirmPassword.value,
                              change: (value) {},
                              validate: (value) {
                                return Validations.validateconfirmPassword(
                                    value!,
                                    context,
                                    workerController.workerPassword.value.text);
                              },
                              disabled: false,
                              phoneField: false,
                              suffix: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: IconButton(
                                  onPressed: () {
                                    workerController.visibleConfirmPassword
                                        .toggle();
                                  },
                                  icon: workerController
                                          .visibleConfirmPassword.value
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
                            height: 12,
                          ),
                          Get.arguments['type'] == 'add'
                              ? FormSubmitButton(
                                  onPressed: () async {
                                    await workerController.createWorker();
                                    await companyDetailsController
                                        .getCompanyWorkers();
                                  },
                                  label: 'Save'.tr,
                                  context: context)
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Material(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50.0),
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: ConstantColors.cardColor,
                                            borderRadius:
                                                BorderRadius.circular(50.0),
                                            border: Border.all(
                                              color:
                                                  ConstantColors.primaryColor,
                                              // Set the border color
                                              width:
                                                  1.0, // Set the border width
                                            ),
                                          ),
                                          child: MaterialButton(
                                            onPressed: () {
                                              if (enabled) {
                                                CompanyWorker worker =
                                                    CompanyWorker(
                                                  id: workerController
                                                      .controller
                                                      .workers[index]
                                                      .id,
                                                  fullName: workerController
                                                      .controller
                                                      .workers[index]
                                                      .fullName,
                                                  phone: workerController
                                                      .controller
                                                      .workers[index]
                                                      .phone,
                                                  title: workerController
                                                      .controller
                                                      .workers[index]
                                                      .title,
                                                  whatsappNumber:
                                                      workerController
                                                          .controller
                                                          .workers[index]
                                                          .whatsappNumber,
                                                  username:
                                                      companyDetailsController
                                                              .company
                                                              .value
                                                              .name! +
                                                          '_' +
                                                          workerController
                                                              .controller
                                                              .workers[index]
                                                              .username!,
                                                  image: workerController
                                                      .controller
                                                      .workers[index]
                                                      .image,
                                                  categories: workerController
                                                      .controller
                                                      .workers[index]
                                                      .categories,
                                                  companyId: workerController
                                                      .controller
                                                      .workers[index]
                                                      .companyId,
                                                  createdAt: workerController
                                                      .controller
                                                      .workers[index]
                                                      .createdAt,
                                                  updatedAt: workerController
                                                      .controller
                                                      .workers[index]
                                                      .updatedAt,
                                                );

                                                worker.fullName =
                                                    workerController
                                                        .workerNameController
                                                        .value
                                                        .text;
                                                worker.phone = workerController
                                                    .workerPhoneNumberController
                                                    .value
                                                    .text;
                                                worker.title = workerController
                                                    .workerTitleController
                                                    .value
                                                    .text;
                                                worker.whatsappNumber =
                                                    workerController
                                                        .workerWhatssappNumberController
                                                        .value
                                                        .text;
                                                        
                                                worker.username =
                                                
                                                    companyDetailsController
                                                            .company
                                                            .value
                                                            .name! +
                                                        '_' +
                                                        workerController
                                                         
                                                            .workerUserName.value.text;
                                                worker.categories =
                                                    List.generate(
                                                  workerController
                                                      .selectedExperties.length,
                                                  (index) => Category(
                                                      id: workerController
                                                              .selectedExperties[
                                                          index]['category_id']),
                                                );
                                                workerController.editWorker(
                                                    worker, index);
                                              }
                                            },
                                            color: ConstantColors.cardColor,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(50.0),
                                            ),
                                            child: Center(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 15.0),
                                                child: Text(
                                                  'Update'.tr,
                                                  style: TextStyle(
                                                    color: ConstantColors
                                                        .primaryColor,
                                                    fontSize: 17,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: localization ==
                                                            "en"
                                                        ? GoogleFonts.roboto()
                                                            .fontFamily
                                                        : 'DubaiFont',
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12,
                                    ),
                                    Expanded(
                                      child: Material(
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0)),
                                        child: MaterialButton(
                                          onPressed: () {
                                            Get.dialog(
                                              DeletePopUp(
                                                deletable: 'worker'.tr,
                                              ),
                                            ).then((result) {
                                              if (result) {
                                                Get.find<
                                                        CompanyWorkersDetailsController>()
                                                    .deleteWorker(
                                                        workerController
                                                            .controller
                                                            .workers[index]
                                                            .id,
                                                        index);
                                              }
                                            });
                                          },
                                          color: ConstantColors.errorColor,
                                          child: Center(
                                              child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 15.0),
                                            child: Text(
                                              'Delete'.tr,
                                              style: TextStyle(
                                                color: ConstantColors.cardColor,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: localization == "en"
                                                    ? GoogleFonts.roboto()
                                                        .fontFamily
                                                    : 'DubaiFont',
                                              ),
                                            ),
                                          )),
                                        ),
                                      ),
                                    )
                                  ],
                                )
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
            workerController.loading.value ? const LoadingWidget() : const Row()
          ],
        ));
  }
}
