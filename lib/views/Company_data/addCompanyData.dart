import 'dart:developer';
import 'dart:io';

import 'package:autoflex/controllers/Company_data/addCompanyData-controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../shared/validations.dart';

class AddCompanyDataScreen extends StatelessWidget {
  AddCompanyDataScreen({super.key});
  final AddCompanyDataController controller =
      Get.put(AddCompanyDataController());
  final CompanyDetailsController companyDetailsController =
      Get.put(CompanyDetailsController());
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
                  child:
                      Get.arguments == null || Get.arguments['type'] == 'edit'
                          ? Text('Company Details'.tr.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge)
                          : Text('Complete Registration'.tr.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge),
                ),
                leading: Get.arguments == null ||
                        Get.arguments['type'] == 'edit'
                    ? Padding(
                        padding: const EdgeInsetsDirectional.only(top: 16.0),
                        child: IconButton(
                          icon: Get.locale?.languageCode == 'en'
                              ? SvgPicture.asset(arrowBack)
                              : Transform.rotate(
                                  angle: 3.14,
                                  child: SvgPicture.asset(arrowBack),
                                ),
                          onPressed: () {
                            Get.delete<AddCompanyDataController>();
                            Get.back();
                            Future.delayed(const Duration(seconds: 2),
                                companyDetailsController.getCompanyDetails());
                          },
                        ),
                      )
                    : const SizedBox(),
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                          key: controller.AddCompanyDataFormKey,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                      controller.companyImage.value!.path
                                              .isNotEmpty
                                          ? Image.file(
                                              File(controller
                                                  .companyImage.value!.path),
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.cover,
                                            )
                                          : companyDetailsController
                                                      .company.value.logo !=
                                                  null
                                              ? CachedNetworkImage(
                                                  imageUrl:
                                                      companyDetailsController
                                                          .company.value.logo!,
                                                  width: 50,
                                                  height: 50,
                                                  fit: BoxFit.cover,
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      SvgPicture.asset(
                                                          image_placeholder_gray))
                                              : SvgPicture.asset(
                                                  imagePlaceholder),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        'Company Logo'.tr.toUpperCase(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                      ),
                                      const SizedBox(
                                        height: 24,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              ConstantColors.secondaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
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
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
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
                                controller.imageMessage.value != ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            textScaleFactor: 1,
                                            controller.imageMessage.value,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              color: ConstantColors.errorColor,
                                              // fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                const SizedBox(
                                  height: 12,
                                ),
                                textField(
                                    validate: (value) {
                                      return Validations.validateName(
                                          value!, context);
                                    },
                                    isPassword: false,
                                    phoneField: false,
                                    disabled: false,
                                    controller:
                                        controller.companyNameController,
                                    hint: 'Company Name'.tr.toUpperCase(),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    context: context,
                                    prefix: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16.0, end: 12),
                                      child: SvgPicture.asset(company),
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                textField(
                                    contentPadding: const EdgeInsets.all(16),
                                    validate: (value) {
                                      return Validations.validatePhone(
                                          value!, context);
                                    },
                                    controller:
                                        controller.companyPhoneController,
                                    isPassword: false,
                                    phoneField: true,
                                    disabled: false,
                                    hint: 'Company Phone'.tr.toUpperCase(),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    context: context,
                                    change: (value) {
                                      controller.isPlaceholderVisible.value = false;
                                      if (!value.startsWith("+971")) {
                                        controller.companyPhoneController.text = "+971";
                                        controller.companyPhoneController.selection =
                                            TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: controller
                                                      .companyPhoneController.text.length),
                                            );
                                      }
                                    },
                                    prefix: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16.0, end: 12),
                                      child: SvgPicture.asset(call),
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                textField(
                                    validate: (value) {
                                      return Validations.validateField(
                                          value!, context);
                                    },
                                    controller:
                                        controller.companyAddressController,
                                    isPassword: false,
                                    phoneField: false,
                                    disabled: false,
                                    hint: 'Address'.tr.toUpperCase(),
                                    hintStyle: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    context: context,
                                    prefix: Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          start: 16.0, end: 12),
                                      child: SvgPicture.asset(address_primary),
                                    )),
                                const SizedBox(
                                  height: 12,
                                ),
                                InkWell(
                                  onTap: () => {controller.addImage('licence')},
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: ConstantColors.cardColor,
                                      border: Border.all(
                                          color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(assignmentAdd),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                controller.licenceImage.value!.path ==
                                                        ''
                                                    ? 'Trade License'
                                                        .tr
                                                        .toUpperCase()
                                                    : controller.licenceImage
                                                        .value!.path,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            controller.licenceImage.value!.path
                                                    .isNotEmpty
                                                ? Image.file(
                                                    File(controller.licenceImage
                                                        .value!.path),
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  )
                                                : companyDetailsController
                                                            .company
                                                            .value
                                                            .tradeLicense !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            companyDetailsController
                                                                .company
                                                                .value
                                                                .tradeLicense!,
                                                        width: 25,
                                                        height: 25,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SvgPicture.asset(
                                                                image_placeholder_gray))
                                                    : SvgPicture.asset(
                                                        image_placeholder_gray),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SvgPicture.asset(new_release)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                // InkWell(
                                //   onTap: () => {
                                //     controller.addImage('licence')
                                //   },
                                //   child: textField( validate: (value) {
                                //         return Validations.validateField(value!, context);
                                //       }, isPassword: false, disabled: true,
                                //       hint: 'Trade License'.toUpperCase(),
                                //       controller:controller.licenceController ,
                                //       hintStyle: Theme.of(context).textTheme.displayMedium,
                                //       context: context,
                                //       prefix: SvgPicture.asset(assignmentAdd),
                                //       suffix: Row(
                                //          mainAxisSize: MainAxisSize.min,
                                //         children: [
                                //           SvgPicture.asset(image_placeholder_gray),
                                //           SizedBox(width: 12,),
                                //           Padding(
                                //             padding: const EdgeInsetsDirectional.only(end:16.0),
                                //             child: SvgPicture.asset(new_release),
                                //           )
                                //       ],)
                                //       ),
                                // ),

                                const SizedBox(
                                  height: 12,
                                ),
                                InkWell(
                                  onTap: () =>
                                      {controller.addImage('passport')},
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: ConstantColors.cardColor,
                                      border: Border.all(
                                          color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(add_primary),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                controller.passportImage.value!
                                                            .path ==
                                                        ''
                                                    ? 'Owner Passport Copy'
                                                        .tr
                                                        .toUpperCase()
                                                    : controller.passportImage
                                                        .value!.path,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            controller.passportImage.value!.path
                                                    .isNotEmpty
                                                ? Image.file(
                                                    File(controller
                                                        .passportImage
                                                        .value!
                                                        .path),
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  )
                                                : companyDetailsController
                                                            .company
                                                            .value
                                                            .passport !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            companyDetailsController
                                                                .company
                                                                .value
                                                                .passport!,
                                                        width: 25,
                                                        height: 25,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SvgPicture.asset(
                                                                image_placeholder_gray))
                                                    : SvgPicture.asset(
                                                        image_placeholder_gray),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SvgPicture.asset(new_release)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                                InkWell(
                                  onTap: () => {controller.addImage('id')},
                                  child: Container(
                                    padding: const EdgeInsets.all(16),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                      color: ConstantColors.cardColor,
                                      border: Border.all(
                                          color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(3),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(add_primary),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            Container(
                                              width: 200,
                                              child: Text(
                                                controller.idImage.value!
                                                            .path ==
                                                        ''
                                                    ? 'Owner Emirates ID'
                                                        .tr
                                                        .toUpperCase()
                                                    : controller
                                                        .idImage.value!.path,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            controller.idImage.value!.path
                                                    .isNotEmpty
                                                ? Image.file(
                                                    File(controller
                                                        .idImage.value!.path),
                                                    width: 25,
                                                    height: 25,
                                                    fit: BoxFit.cover,
                                                  )
                                                : companyDetailsController
                                                            .company
                                                            .value
                                                            .ownerEmiratesId !=
                                                        null
                                                    ? CachedNetworkImage(
                                                        imageUrl:
                                                            companyDetailsController
                                                                .company
                                                                .value
                                                                .ownerEmiratesId!,
                                                        width: 25,
                                                        height: 25,
                                                        fit: BoxFit.cover,
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            SvgPicture.asset(
                                                                image_placeholder_gray))
                                                    : SvgPicture.asset(
                                                        image_placeholder_gray),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            SvgPicture.asset(release_alert)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                controller.errorMessage.value != ""
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            overflow: TextOverflow.visible,
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
                                const SizedBox(
                                  height: 12,
                                ),
                                Get.arguments == null ||
                                        Get.arguments['type'] == 'add'
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ConstantColors
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Material(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              child: MaterialButton(
                                                onPressed: () => Get.arguments == null
                                                    ? controller.addCompanyDetails(
                                                        logo: controller
                                                            .companyImage
                                                            .value!
                                                            .path,
                                                        license: controller
                                                            .licenceImage
                                                            .value!
                                                            .path,
                                                        passport: controller
                                                            .passportImage
                                                            .value!
                                                            .path,
                                                        name: controller
                                                            .companyNameController
                                                            .text,
                                                        phone: controller
                                                            .companyPhoneController
                                                            .text,
                                                        address: controller
                                                            .companyAddressController
                                                            .text,
                                                        idCard: controller
                                                            .idImage
                                                            .value!
                                                            .path)
                                                    : controller.updateCompanyDetails(
                                                        logo: controller.companyImage.value!.path,
                                                        license: controller.licenceImage.value!.path,
                                                        passport: controller.passportImage.value!.path,
                                                        name: controller.companyNameController.text,
                                                        phone: controller.companyPhoneController.text,
                                                        address: controller.companyAddressController.text,
                                                        idCard: controller.idImage.value!.path),
                                                color:
                                                    ConstantColors.primaryColor,
                                                child: Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15.0),
                                                  child: Text(
                                                    'Update'.tr,
                                                    style: TextStyle(
                                                      color: ConstantColors
                                                          .cardColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          localization == "en"
                                                              ? GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont',
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.3,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ConstantColors
                                                        .primaryColor),
                                                borderRadius:
                                                    BorderRadius.circular(50)),
                                            child: Material(
                                              clipBehavior: Clip.antiAlias,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0)),
                                              child: MaterialButton(
                                                onPressed: () => Get.to(
                                                    () =>
                                                        CompanyDetailsScreen(),
                                                    arguments: {
                                                      'data': 'empty'
                                                    }),
                                                color: ConstantColors.cardColor,
                                                child: Center(
                                                    child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      vertical: 15.0),
                                                  child: Text(
                                                    'Skip'.tr,
                                                    style: TextStyle(
                                                      color: ConstantColors
                                                          .primaryColor,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      fontFamily:
                                                          localization == "en"
                                                              ? GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont',
                                                    ),
                                                  ),
                                                )),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Get.arguments['type'] == 'edit'
                                        ? FormSubmitButton(
                                            onPressed: () {
                                              Get.arguments == null
                                                  ? controller.addCompanyDetails(
                                                      logo: controller
                                                          .companyImage
                                                          .value!
                                                          .path,
                                                      license: controller
                                                          .licenceImage
                                                          .value!
                                                          .path,
                                                      passport: controller
                                                          .passportImage
                                                          .value!
                                                          .path,
                                                      name: controller
                                                          .companyNameController
                                                          .text,
                                                      phone: controller
                                                          .companyPhoneController
                                                          .text,
                                                      address: controller
                                                          .companyAddressController
                                                          .text,
                                                      idCard: controller
                                                          .idImage.value!.path)
                                                  : controller.updateCompanyDetails(
                                                      logo: controller
                                                          .companyImage
                                                          .value!
                                                          .path,
                                                      license: controller.licenceImage.value!.path,
                                                      passport: controller.passportImage.value!.path,
                                                      name: controller.companyNameController.text,
                                                      phone: controller.companyPhoneController.text,
                                                      address: controller.companyAddressController.text,
                                                      idCard: controller.idImage.value!.path);
                                            },
                                            label: 'Update'.tr)
                                        : SizedBox(),
                              ]))))),
          controller.loading.value ? const LoadingWidget() : const Row()
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
              const SizedBox(
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
