import 'dart:io';

import 'package:autoflex/controllers/Home/worker/workerData-controller.dart';
import 'package:autoflex/controllers/worker/worker_menu_controller.dart';
import 'package:autoflex/models/company%20workers/WorkerDetails.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controllers/Company_data/addCompanyData-controller.dart';
import '../../../main.dart';
import '../../../shared/components/formSubmitButton.dart';
import '../../../shared/components/text-field.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';
import '../../../shared/validations.dart';

class WorkerDataScreen extends StatefulWidget {
  WorkerDataScreen({super.key});

  @override
  State<WorkerDataScreen> createState() => _WorkerDataScreenState();
}

class _WorkerDataScreenState extends State<WorkerDataScreen> {
  final WorkerDataController controller = Get.put(WorkerDataController());
  final WorkerMenuController workerController =
      Get.find<WorkerMenuController>();
  @override
  void initState() {
    controller.phoneController.text =
        "${controller.workerMenuController.workerDetails.value.data!.phone ?? ''}";
    controller.whatsappController.text =
        "${controller.workerMenuController.workerDetails.value.data!.whatsappNumber ?? ''}";
    controller.isPlaceholderVisible.value =
        controller.phoneController.text == "+971";
    controller.iswhatsAppPlaceholderVisible.value =
        controller.whatsappController.text == "+971";
    controller.showwhatsApp.value =
        controller.phoneController.text != controller.whatsappController.text;
    controller.nameController.text =
        controller.workerMenuController.workerDetails.value.data!.fullName ??
            '';
    super.initState();
  }

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
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: Text('Personal Details'.tr.toUpperCase(),
                      style: Theme.of(context).textTheme.titleLarge),
                ),
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
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                          // key: controller.AddCompanyDataFormKey,
                          child: Column(children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: ConstantColors.cardColor,
                              border: Border.all(
                                color: ConstantColors.borderColor,
                              ),
                              borderRadius: BorderRadius.circular(7)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              controller.workerImage.value!.path.isNotEmpty
                                  ? Image.file(
                                      File(controller.workerImage.value!.path),
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.cover,
                                    )
                                  : workerController.workerDetails.value.data
                                              ?.image !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: workerController
                                              .workerDetails.value.data!.image!,
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                          errorWidget: (context, url, error) =>
                                              SvgPicture.asset(
                                                  imagePlaceholder))
                                      : SvgPicture.asset(imagePlaceholder),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                'Upload Photo '.tr.toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      ConstantColors.secondaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                  ),
                                  child: Text(
                                    'upload'.tr.toUpperCase(),
                                    style: TextStyle(
                                      color: ConstantColors.cardColor,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: localization == "en"
                                          ? GoogleFonts.roboto().fontFamily
                                          : 'DubaiFont',
                                    ),
                                  ),
                                ),
                                onPressed: () =>
                                    {uploadImageBottomSheet(context)},
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
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
                                    child: Text(
                                      'Phone number'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displaySmall,
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
                                              child: Text(
                                                'Whats App Number'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displaySmall,
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
                                'Are you using different number for WhatsApp?'
                                    .tr,
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
                        FormSubmitButton(
                            label: 'Update'.tr,
                            context: context,
                            onPressed: () {
                              controller.updateDetails();
                            }),
                      ]))))),
          controller.loading.value ? const LoadingWidget() : Row()
        ],
      ),
    );
  }

  Future<dynamic> uploadImageBottomSheet(BuildContext context) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 30, maxHeight: 268),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        // backgroundColor: ConstantColors.backgroundColor,
        builder: (BuildContext context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ConstantColors.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(mainAxisSize: MainAxisSize.min, children: [
                  InkWell(
                    onTap: () {
                      controller.changePhotoRequest('camera');
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Take Photo'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(cameraIcon)
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: ConstantColors.borderColor,
                  ),
                  InkWell(
                    onTap: () {
                      controller.changePhotoRequest('gallery');
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Photo Library'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(imagePlaceholder_selected)
                        ],
                      ),
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: ConstantColors.borderColor,
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Browse'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(moreIcon)
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: ConstantColors.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 17.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Center(
                      child: Text(
                        'Cancel'.tr,
                        style: TextStyle(
                          color: ConstantColors.secondaryColor,
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
        context: context);
  }
}
