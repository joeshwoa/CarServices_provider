import 'dart:developer';
import 'dart:ffi';
import 'dart:math';

import 'package:autoflex/controllers/Company_data/addCompanyData-controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/shared/components/copmanyDataItem.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/addCompanyData.dart';
import 'package:autoflex/views/Company_data/services/manageServices.dart';
import 'package:autoflex/views/Company_data/bank/manage_bank_accounts.dart';
import 'package:autoflex/views/Company_data/bussines%20hours/manage_hours.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';
import 'package:autoflex/views/Company_data/service_areas.dart';
import 'package:autoflex/views/Home/provider/menu.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';
import 'package:shimmer/shimmer.dart';

import '../../main.dart';
import '../../shared/components/serviceButton.dart';
import '../../shared/styles/colors.dart';

class CompanyDetailsScreen extends StatelessWidget {
  CompanyDetailsScreen({super.key});
  final CompanyDetailsController controller =
      Get.find<CompanyDetailsController>();
  final AddCompanyDataController addCompanycontroller =
      Get.find<AddCompanyDataController>();
  @override
  Widget build(BuildContext context) {
    inspect(sharedPreferenceController.userData.value.data!.hasCompany!);
    inspect(sharedPreferenceController.userData.value.data!.isCompleted!);
    inspect(sharedPreferenceController.userData.value.data!.isApproved!);
    return Obx(
      () => Scaffold(
        backgroundColor: ConstantColors.backgroundColor,
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          leading: sharedPreferenceController.userData.value.data!.hasCompany!
              ? sharedPreferenceController.userData.value.data!.hasCompany! &&
                      !sharedPreferenceController
                          .userData.value.data!.isCompleted!
                  ? IconButton(
                      icon: SvgPicture.asset(menu),
                      onPressed: () {
                        Get.to(() => MenuScreen());
                      },
                    )
                  : IconButton(
                      icon: Get.locale?.languageCode == 'en'
                          ? SvgPicture.asset(arrowBack)
                          : Transform.rotate(
                              angle: 3.14,
                              child: SvgPicture.asset(arrowBack),
                            ),
                      onPressed: () {
                        Get.back();
                      },
                    )
              : null,
          title: SvgPicture.asset(logo),
          centerTitle:
              sharedPreferenceController.userData.value.data!.hasCompany!
                  ? true
                  : false,
          automaticallyImplyLeading: false,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: InkWell(
                onTap: () async {
                  if (sharedPreferenceController.localization.value == 'en') {
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
                      'العربية'.tr,
                      style: TextStyle(
                          fontSize: 11,
                          color: ConstantColors.primaryColor,
                          fontFamily: localization == "en"
                              ? GoogleFonts.roboto().fontFamily
                              : 'DubaiFont',
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    SvgPicture.asset(language),
                  ],
                ),
              ),
            )
          ],
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            if (sharedPreferenceController.userData.value.data!.hasCompany!) {
              await controller.getCompanyDetails();
              await controller.getCompanyServices();
              await controller.getBlockedDates();
              await controller.getWorkingHours();
              await controller.getServiceAreas();
              await controller.getCompanyWorkers();
              await controller.getBankAccounts();
            }
          },
          child: SingleChildScrollView(
              child: controller.loading.value
                  ? Column(
                      children: List.generate(
                          6,
                          (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8, horizontal: 16),
                                child: Shimmer.fromColors(
                                  baseColor: Colors.grey[300]!,
                                  highlightColor: Colors.grey[100]!,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        color: Colors.white),
                                    height: 150,
                                    width: double.infinity,
                                  ),
                                ),
                              )),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32),
                      child: Column(children: [
                        sharedPreferenceController
                                    .userData.value.data!.hasCompany! &&
                                sharedPreferenceController
                                    .userData.value.data!.isCompleted! &&
                                sharedPreferenceController
                                    .userData.value.data!.isApproved!
                            ? SizedBox()
                            : Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: ConstantColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(circle_notifications),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              //     !sharedPreferenceController.userData.value.data
                                              //     !.hasCompany!?
                                              //     'Add Your Company to Access Dashboard'.tr
                                              //  :

                                              !sharedPreferenceController
                                                      .userData
                                                      .value
                                                      .data!
                                                      .isApproved!
                                                  ? 'Company Still Not Approved'
                                                      .tr
                                                  : !sharedPreferenceController
                                                          .userData
                                                          .value
                                                          .data!
                                                          .isCompleted!
                                                      ? 'Complete Company Setup to Access Dashboard'
                                                          .tr
                                                      : '',
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color:
                                                      ConstantColors.cardColor,
                                                  fontFamily:
                                                      GoogleFonts.roboto()
                                                          .fontFamily,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            !sharedPreferenceController
                                                        .userData
                                                        .value
                                                        .data!
                                                        .isCompleted! &&
                                                    !sharedPreferenceController
                                                        .userData
                                                        .value
                                                        .data!
                                                        .isApproved!
                                                ? Text(
                                                    "In The Meantime Please Complete Your Company's Setup"
                                                        .tr,
                                                    style: TextStyle(
                                                        fontSize: 9,
                                                        color: ConstantColors
                                                            .cardColor,
                                                        fontFamily:
                                                            GoogleFonts.roboto()
                                                                .fontFamily,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  )
                                                : SizedBox()
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                        const SizedBox(
                          height: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            controller.company.value.phone != null
                                ? DataItem(
                                    title: 'Company Details'.tr.toUpperCase(),
                                    editScreen: () {
                                      addCompanycontroller.resetKey();
                                      Get.delete<AddCompanyDataController>();
                                      Get.to(() => AddCompanyDataScreen(),
                                          arguments: {'type': 'edit'});
                                    },
                                    logo: controller.company.value.logo != null
                                        ? CachedNetworkImage(
                                            imageUrl:
                                                controller.company.value.logo!,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.cover,
                                            errorWidget:
                                                (context, url, error) =>
                                                    SvgPicture.asset(
                                                        image_placeholder_gray),
                                          )
                                        : SvgPicture.asset(imagePlaceholder),
                                    description: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.company.value.name ?? "",
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w400,
                                              color: ConstantColors.bodyColor3,
                                              fontFamily: localization == "en"
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
                                                  : 'DubaiFont'),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Phone: '.tr,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ConstantColors.bodyColor,
                                                  fontFamily:
                                                      localization == "en"
                                                          ? GoogleFonts.roboto()
                                                              .fontFamily
                                                          : 'DubaiFont'),
                                            ),
                                            Text(
                                              controller.company.value.phone ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ConstantColors.bodyColor3,
                                                  fontFamily:
                                                      localization == "en"
                                                          ? GoogleFonts.roboto()
                                                              .fontFamily
                                                          : 'DubaiFont'),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address: '.tr,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w400,
                                                  color:
                                                      ConstantColors.bodyColor,
                                                  fontFamily:
                                                      localization == "en"
                                                          ? GoogleFonts.roboto()
                                                              .fontFamily
                                                          : 'DubaiFont'),
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller.company.value
                                                        .address ??
                                                    "",
                                                style: TextStyle(
                                                    fontSize: 11,
                                                    overflow:
                                                        TextOverflow.visible,
                                                    fontWeight: FontWeight.w400,
                                                    color: ConstantColors
                                                        .bodyColor3,
                                                    fontFamily: localization ==
                                                            "en"
                                                        ? GoogleFonts.roboto()
                                                            .fontFamily
                                                        : 'DubaiFont'),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ))
                                : createButton(
                                    label: 'Add Company Logo & Details'
                                        .tr
                                        .toUpperCase(),
                                    prefixIcon: diamond,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      addCompanycontroller.resetKey();
                                      Get.to(() => AddCompanyDataScreen());
                                    }),
                            controller.services.value.isNotEmpty
                                ? DataItem(
                                    title: 'Manage Services'.tr.toUpperCase(),
                                    editScreen: () {
                                      Get.to(() => ManageServicesScreen());
                                    },
                                    prefix: SvgPicture.asset(engineWorks),
                                    description: Text(
                                      controller.services.value
                                          .map((service) => service.name)
                                          .join(', '),
                                      style: TextStyle(
                                          overflow: TextOverflow.visible,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                          color: ConstantColors.bodyColor,
                                          fontFamily: localization == "en"
                                              ? GoogleFonts.roboto().fontFamily
                                              : 'DubaiFont'),
                                    ),
                                  )
                                : createButton(
                                    label: 'Add Services'.tr.toUpperCase(),
                                    prefixIcon: engineWorks,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      Get.to(() => ManageServicesScreen());
                                    }),
                            controller.workingHours.isNotEmpty
                                ? Obx(
                                    () => DataItem(
                                        title: 'Manage Business hours & Days '
                                            .tr
                                            .toUpperCase(),
                                        editScreen: () {
                                          Get.to(() => ManageHoursScreen());
                                        },
                                        prefix: SvgPicture.asset(calenderClock),
                                        description: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children:
                                                    (controller
                                                        .workingHours.value
                                                        .map((workDay) => Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              // mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                SizedBox(
                                                                  width: 60,
                                                                  child: Text(
                                                                    workDay['day']
                                                                        .toString()
                                                                        .tr
                                                                        .toString(),
                                                                    style: TextStyle(
                                                                        overflow:
                                                                            TextOverflow
                                                                                .visible,
                                                                        fontSize:
                                                                            11,
                                                                        fontWeight:
                                                                            FontWeight
                                                                                .w700,
                                                                        color: ConstantColors
                                                                            .bodyColor,
                                                                        fontFamily: localization ==
                                                                                "en"
                                                                            ? GoogleFonts.roboto().fontFamily
                                                                            : 'DubaiFont'),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                FittedBox(
                                                                  fit: BoxFit
                                                                      .scaleDown,
                                                                  child: Text(
                                                                    workDay[
                                                                        'hours'],
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: workDay['hours'] ==
                                                                              'Closed'
                                                                                  .tr
                                                                          ? ConstantColors
                                                                              .errorColor
                                                                          : ConstantColors
                                                                              .bodyColor,
                                                                      fontFamily: localization ==
                                                                              "en"
                                                                          ? GoogleFonts.roboto()
                                                                              .fontFamily
                                                                          : 'DubaiFont',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ))
                                                        .toList()),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Text('Blocked Dates'.tr,
                                                  style: TextStyle(
                                                      overflow:
                                                          TextOverflow.visible,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: ConstantColors
                                                          .errorColor,
                                                      fontFamily:
                                                          localization == "en"
                                                              ? GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont')),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              controller.blockedDates.isNotEmpty
                                                  ? Text(
                                                      controller
                                                          .blockedDates.value
                                                          .toString()
                                                          .substring(
                                                              1,
                                                              controller
                                                                      .blockedDates
                                                                      .value
                                                                      .toString()
                                                                      .length -
                                                                  1),
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .visible,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ConstantColors
                                                              .bodyColor2,
                                                          fontFamily: localization ==
                                                                  "en"
                                                              ? GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont'),
                                                    )
                                                  : Text('No Blocked Dates'.tr,
                                                      style: TextStyle(
                                                          overflow: TextOverflow
                                                              .visible,
                                                          fontSize: 11,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: ConstantColors
                                                              .borderColor,
                                                          fontFamily: localization ==
                                                                  "en"
                                                              ? GoogleFonts
                                                                      .roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont')),
                                            ])),
                                  )
                                : createButton(
                                    label: 'Set Business hours & Days'
                                        .tr
                                        .toUpperCase(),
                                    prefixIcon: schedule_2,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      Get.to(() => ManageHoursScreen());
                                    }),
                            controller.servicesAreas.isNotEmpty
                                ? DataItem(
                                    title:
                                        'Manage Service Areas'.tr.toUpperCase(),
                                    editScreen: () {
                                      Get.to(() => ServiceAreasScreen());
                                    },
                                    prefix: SvgPicture.asset(location_on),
                                    description: Column(
                                      children: controller.servicesAreas
                                          .map((area) => Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        area.emirateName ?? "",
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow
                                                                    .visible,
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            color:
                                                                ConstantColors
                                                                    .bodyColor,
                                                            fontFamily: localization ==
                                                                    "en"
                                                                ? GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily
                                                                : 'DubaiFont'),
                                                      ),
                                                      Expanded(
                                                        child: Text(
                                                          ' (${area.cities!.map((city) => city.cityName).join(', ')})',
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .visible,
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color:
                                                                  ConstantColors
                                                                      .bodyColor,
                                                              fontFamily: localization ==
                                                                      "en"
                                                                  ? GoogleFonts
                                                                          .roboto()
                                                                      .fontFamily
                                                                  : 'DubaiFont'),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  )
                                                ],
                                              ))
                                          .toList(),
                                    ))
                                : createButton(
                                    label: 'Set Service Areas'.tr.toUpperCase(),
                                    prefixIcon: location_on,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      Get.to(() => ServiceAreasScreen());
                                    }),
                            controller.workers.isNotEmpty
                                ? DataItem(
                                    title: 'Manage Workers'.tr.toUpperCase(),
                                    prefix: SvgPicture.asset(account_circle),
                                    editScreen: () {
                                      Get.to(() => ManageWorkersScreen());
                                    },
                                    description: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: controller.workers
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        int index = entry.key;
                                        var worker = entry.value;
                                        return Text(
                                          (index + 1).toString() +
                                              '. ' +
                                              worker,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: ConstantColors.bodyColor2,
                                              fontFamily: localization == "en"
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
                                                  : 'DubaiFont'),
                                        );
                                      }).toList(),
                                    ))
                                : createButton(
                                    label: 'Add Workers'.tr.toUpperCase(),
                                    prefixIcon: account_circle,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      Get.to(() => ManageWorkersScreen());
                                    }),
                            controller.bankAccounts.isNotEmpty
                                ? DataItem(
                                    title:
                                        'Manage Bank Accounts'.tr.toUpperCase(),
                                    prefix: SvgPicture.asset(account_balance),
                                    editScreen: () {
                                      Get.to(() => ManageBankAccountsScreen());
                                    },
                                    description: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: controller.bankAccounts
                                          .map((bankAccount) {
                                        var index = controller.bankAccounts
                                            .indexOf(bankAccount);
                                        return Text(
                                          (index + 1).toString() +
                                              '. ' +
                                              bankAccount,
                                          style: TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: ConstantColors.bodyColor2,
                                              fontFamily: localization == "en"
                                                  ? GoogleFonts.roboto()
                                                      .fontFamily
                                                  : 'DubaiFont'),
                                        );
                                      }).toList(),
                                    ))
                                : createButton(
                                    label: 'Add Bank Details'.tr.toUpperCase(),
                                    prefixIcon: account_balance,
                                    suffixIcon: addOutlined,
                                    screen: () {
                                      Get.to(() => ManageBankAccountsScreen());
                                    }),
                          ],
                        )
                      ]))),
        ),
      ),
    );
  }
}
