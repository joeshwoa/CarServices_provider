import 'package:autoflex/controllers/Company_data/bussines%20hours/block_days_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/select_date.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class BlockWorkDaysScreen extends StatelessWidget {
  BlockWorkDaysScreen({super.key});
  BlockDaysController blockDaysController = Get.put(BlockDaysController());
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          Scaffold(
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
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Block Non-Operational Days'.tr,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'If your company is not working other then your regular weekends - block those days here so you will not receive any booking.'.tr,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(color: ConstantColors.primaryColor),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: ConstantColors.cardColor,
                          border: Border.all(color: ConstantColors.borderColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: ExpansionTile(
                        iconColor: ConstantColors.hintColor,
                        collapsedIconColor: ConstantColors.hintColor,
                        initiallyExpanded: true,
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        title: Text(
                          '${blockDaysController.currentMonth} ${blockDaysController.year}'
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: blockDaysController.loading.value
                                    ? [
                                        ...List.generate(
                                            30,
                                            (index) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0,
                                                    left: 4,
                                                    right: 4),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.12,
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        Colors.grey[300]!,
                                                    highlightColor:
                                                        Colors.grey[100]!,
                                                    child: Container(
                                                      decoration: const BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          10)),
                                                          color: Colors.white),
                                                      height: 45,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                )))
                                      ]
                                    : blockDaysController.currentMonthDays
                                        .map(
                                          (day) => Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, left: 4, right: 4),
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.12,
                                              child: InkWell(
                                                onTap: () {
                                                  if (blockDaysController
                                                      .currentblockedDays
                                                      .contains(day)) {
                                                    blockDaysController
                                                        .unBlockDay(day, true);
                                                  } else {
                                                    blockDaysController
                                                        .blockDay(day, true);
                                                  }
                                                },
                                                child: FractionallySizedBox(
                                                  widthFactor: 1,
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(4),
                                                    decoration: BoxDecoration(
                                                      color: blockDaysController
                                                              .currentblockedDays
                                                              .contains(day)
                                                          ? ConstantColors
                                                              .errorColor
                                                          : ConstantColors
                                                              .backgroundColor,
                                                      border: Border.all(
                                                          color: ConstantColors
                                                              .borderColor),
                                                      borderRadius:
                                                          const BorderRadius
                                                              .all(
                                                              Radius.circular(
                                                                  8)),
                                                    ),
                                                    child: Text(
                                                      '${day.substring(0, 3).toUpperCase()}\n${day.substring(3)}',
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: blockDaysController
                                                              .currentblockedDays
                                                              .contains(day)
                                                          ? TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color:
                                                                  ConstantColors
                                                                      .bodyColor2,
                                                              fontFamily: localization ==
                                                                      "en"
                                                                  ? GoogleFonts
                                                                          .roboto()
                                                                      .fontFamily
                                                                  : 'DubaiFont')
                                                          : Theme.of(context)
                                                              .textTheme
                                                              .labelMedium,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                        .toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    blockDaysController.loading.value
                        ? Shimmer.fromColors(
                            baseColor: Colors.grey[300]!,
                            highlightColor: Colors.grey[100]!,
                            child: Container(
                              decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  color: Colors.white),
                              height: 80,
                              width: double.infinity,
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                                color: ConstantColors.cardColor,
                                border: Border.all(
                                    color: ConstantColors.borderColor),
                                borderRadius: BorderRadius.circular(10)),
                            child: ExpansionTile(
                              iconColor: ConstantColors.hintColor,
                              collapsedIconColor: ConstantColors.hintColor,
                              initiallyExpanded: false,
                              expandedCrossAxisAlignment:
                                  CrossAxisAlignment.start,
                              title: Text(
                                '${blockDaysController.nextMonth} ${blockDaysController.year}'
                                    .toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium,
                              ),
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Obx(
                                    () => SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.9,
                                      child: Wrap(
                                        alignment: WrapAlignment.center,
                                        children: blockDaysController
                                            .nextMonthDays
                                            .map(
                                              (day) => Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0,
                                                    left: 4,
                                                    right: 4),
                                                child: SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.12,
                                                  child: InkWell(
                                                    onTap: () {
                                                      if (blockDaysController
                                                          .nextBlockedDays
                                                          .contains(day)) {
                                                        blockDaysController
                                                            .unBlockDay(
                                                                day, false);
                                                      } else {
                                                        blockDaysController
                                                            .blockDay(
                                                                day, false);
                                                      }
                                                    },
                                                    child: FractionallySizedBox(
                                                      widthFactor: 1,
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: blockDaysController
                                                                  .nextBlockedDays
                                                                  .contains(day)
                                                              ? ConstantColors
                                                                  .errorColor
                                                              : ConstantColors
                                                                  .backgroundColor,
                                                          border: Border.all(
                                                              color: ConstantColors
                                                                  .borderColor),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          8)),
                                                        ),
                                                        child: Text(
                                                          '${day.substring(0, 3).toUpperCase()}\n${day.substring(3)}',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: blockDaysController
                                                                  .nextBlockedDays
                                                                  .contains(day)
                                                              ? TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w700,
                                                                  color: ConstantColors
                                                                      .bodyColor2,
                                                                  fontFamily: localization ==
                                                                          "en"
                                                                      ? GoogleFonts
                                                                              .roboto()
                                                                          .fontFamily
                                                                      : 'DubaiFont')
                                                              : Theme.of(
                                                                      context)
                                                                  .textTheme
                                                                  .labelMedium,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 16,
                    ),
                    FormSubmitButton(
                        onPressed: () async {
                          await blockDaysController.blockSelectedDates();
                          await companyDetailsController.getBlockedDates();
                        },
                        label: 'Save'.tr)
                  ],
                ),
              ),
            ),
          ),
          blockDaysController.blocking.value
              ? const LoadingWidget()
              : const Row()
        ],
      ),
    );
  }
}
