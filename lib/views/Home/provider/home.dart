import 'dart:ffi';

import 'package:autoflex/controllers/Home/home-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/models/orders.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/views/Home/provider/manageJobs.dart';
import 'package:autoflex/views/Home/provider/menu.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:custom_rating_bar/custom_rating_bar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/styles/icons_assets.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final HomeController controller = Get.put(HomeController());

  static const route = '/home-screen';
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: Stack(
          children: [
            Scaffold(
                backgroundColor: ConstantColors.backgroundColor,
                appBar: AppBar(
                  elevation: 0.0,
                  backgroundColor: ConstantColors.backgroundColor,
                  centerTitle: true,
                  leading: IconButton(
                    icon: SvgPicture.asset(menu),
                    onPressed: () {
                      Get.to(() => MenuScreen());
                    },
                  ),
                  title: SvgPicture.asset(logo),
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset(controller.unseenMessages.value?notificationsUnread:notificationsRead, color: ConstantColors.secondaryColor,),
                      onPressed: () async {
                        controller.showNotification.value = !controller.showNotification.value;
                        if(controller.showNotification.value) {
                          await controller.getNotifications();
                          controller.readAllNotifications();
                        }
                      },
                    )
                  ],
                ),
                body: controller.loading.value
                    ? SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                              4,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 16),
                                    child: Shimmer.fromColors(
                                      baseColor: Colors.grey[300]!,
                                      highlightColor: Colors.grey[100]!,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                            borderRadius:
                                                BorderRadius.all(Radius.circular(10)),
                                            color: Colors.white),
                                        height: 100,
                                        width: double.infinity,
                                      ),
                                    ),
                                  )),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 32),
                            child: Column(children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 12),
                                decoration: BoxDecoration(
                                    color: ConstantColors.primaryColor,
                                    borderRadius: BorderRadius.circular(8)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                              controller.message.value.notification != null && controller.message.value.notification!.title != null? controller.message.value.notification!.title! : controller.getNotificationsRequest!.data!.isNotEmpty ? controller.getNotificationsRequest!.data![0].title! : 'No new notifications'.tr,
                                              style: TextStyle(
                                                  fontSize: 11,
                                                  color: ConstantColors.cardColor,
                                                  fontFamily:
                                                      GoogleFonts.roboto().fontFamily,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            Text(
                                              controller.message.value.notification != null && controller.message.value.notification!.body != null? controller.message.value.notification!.body! : controller.getNotificationsRequest!.data!.isNotEmpty ? controller.getNotificationsRequest!.data![0].body! : 'No new notifications'.tr,
                                              style: TextStyle(
                                                  fontSize: 9,
                                                  color: ConstantColors.cardColor,
                                                  fontFamily:
                                                      GoogleFonts.roboto().fontFamily,
                                                  fontWeight: FontWeight.w400),
                                            )
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: ConstantColors.cardColor,
                                        border: Border.all(
                                            color: ConstantColors.borderColor),
                                      ),
                                      child: ExpansionTile(
                                        childrenPadding: const EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 20),
                                        iconColor: ConstantColors.hintColor,
                                        collapsedIconColor: ConstantColors.hintColor,
                                        initiallyExpanded: false,
                                        expandedCrossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        title: Text(
                                          'Company Earnings & Payments'.tr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineMedium,
                                        ),
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 20),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        ConstantColors.borderColor),
                                                borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(8),
                                                    topRight: Radius.circular(8))),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(phone),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Life Time Earnings'.tr
                                                              .toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          'Current Earning'.tr
                                                              .toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          'Available to '.tr
                                                              .toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          'Withdraw'.tr.toUpperCase(),
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .bodySmall,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment.start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.start,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Text(
                                                          '${'AED'.tr} ${controller.getEarningRequest!.data!.lifeTimeEarning!}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${'AED'.tr} ${controller.getEarningRequest!.data!.currentEarning}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Text(
                                                          '${'AED'.tr} ${controller.getEarningRequest!.data!.availableToWithdraw}',
                                                          style: Theme.of(context)
                                                              .textTheme
                                                              .titleMedium,
                                                        ),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.withdraw();
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 8, horizontal: 16),
                                              decoration: const BoxDecoration(
                                                  color: ConstantColors.primaryColor,
                                                  borderRadius: BorderRadius.only(
                                                      bottomLeft: Radius.circular(8),
                                                      bottomRight: Radius.circular(8))),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(
                                                    'Withdraw'.tr.toUpperCase(),
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.white,
                                                        fontFamily: GoogleFonts.roboto()
                                                            .fontFamily,
                                                        fontWeight: FontWeight.w700),
                                                  ),
                                                  // SvgPicture.asset(navigateNext)
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Center(
                                              child: Text(
                                            'Company Earnings'.tr,
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayLarge,
                                          )),
                                          const SizedBox(
                                            height: 12,
                                          ),
                                          /*SvgPicture.asset('assets/images/chart.svg')*/
                                          AspectRatio(
                                            aspectRatio: 16 / 9,
                                            child: BarChart(
                                              BarChartData(
                                                  borderData: FlBorderData(
                                                    border: const Border(
                                                      top: BorderSide.none,
                                                      right: BorderSide.none,
                                                      left: BorderSide(width: 1),
                                                      bottom: BorderSide(width: 1),
                                                    ),
                                                  ),
                                                  groupsSpace: 0,
                                                  titlesData: FlTitlesData(
                                                      rightTitles: const AxisTitles(
                                                          drawBelowEverything: false),
                                                      topTitles: const AxisTitles(
                                                          drawBelowEverything: false),
                                                      bottomTitles: AxisTitles(
                                                          axisNameWidget: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional.only(start: 40),
                                                        child: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            for (int i = 0;
                                                                i <
                                                                    controller
                                                                        .getEarningRequest!
                                                                        .data!
                                                                        .months!
                                                                        .length;
                                                                i++) ...[
                                                              Text(
                                                                '${controller.getEarningRequest!.data!.months![i].month.toString()} ${controller.getEarningRequest!.data!.months![i].year.toString()}',
                                                                style: const TextStyle(
                                                                    fontSize: 10),
                                                              ),
                                                            ],
                                                          ],
                                                        ),
                                                      ))),
                                                  maxY: 300000,
                                                  minY: 0,
                                                  barGroups: [
                                                    for (int i = 0;
                                                        i <
                                                            controller
                                                                .getEarningRequest!
                                                                .data!
                                                                .months!
                                                                .length;
                                                        i++) ...[
                                                      BarChartGroupData(
                                                          x: 1,
                                                          barRods: [
                                                            BarChartRodData(
                                                                fromY: 0,
                                                                toY: controller
                                                                    .getEarningRequest!
                                                                    .data!
                                                                    .months![i]
                                                                    .completed!
                                                                    .toDouble(),
                                                                width: 15,
                                                                color: Colors.blue,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            BarChartRodData(
                                                                fromY: 0,
                                                                toY: controller
                                                                    .getEarningRequest!
                                                                    .data!
                                                                    .months![i]
                                                                    .rejected!
                                                                    .toDouble(),
                                                                width: 15,
                                                                color: Colors.grey,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                            BarChartRodData(
                                                                fromY: 0,
                                                                toY: controller
                                                                    .getEarningRequest!
                                                                    .data!
                                                                    .months![i]
                                                                    .failed!
                                                                    .toDouble(),
                                                                width: 15,
                                                                color: Colors.red,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .zero),
                                                          ]),
                                                    ],
                                                  ]),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.symmetric(vertical: 12.0),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () =>
                                                  {Get.to(() => ManageJobsScreen())},
                                              child: Container(
                                                padding:
                                                    const EdgeInsetsDirectional.all(
                                                        16),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color:
                                                        ConstantColors.primaryColor),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SvgPicture.asset(redCircle),
                                                        const SizedBox(
                                                          width: 4,
                                                        ),
                                                        Text(
                                                          '${controller.getEarningRequest!.data!.newJobs} ${'New Jobs'.tr}'
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              fontSize: 15,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w400),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 25,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'Assign to Worker'.tr
                                                              .toUpperCase(),
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Expanded(
                                            child: InkWell(
                                              onTap: () => {
                                                Get.to(()=>ManageJobsScreen())
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsetsDirectional.all(
                                                        16),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                    color: ConstantColors
                                                        .secondaryColor),
                                                child: Column(
                                                  children: [
                                                    Text(
                                                      '${controller.getEarningRequest!.data!.todayJobs} ${'Jobs for today'.tr}'
                                                          .toUpperCase(),
                                                      style: const TextStyle(
                                                          fontSize: 15,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    const SizedBox(
                                                      height: 20,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          'View'.tr.toUpperCase(),
                                                          style: const TextStyle(
                                                              fontSize: 11,
                                                              color: Colors.white,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Get.locale?.languageCode == 'en'
                                                            ? SvgPicture.asset(
                                                          navigateNextWhite)
                                                            : Transform.rotate(
                                                          angle: 3.14,
                                                          child: SvgPicture.asset(
                                                              navigateNextWhite
                                                          ),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    controller.newJobs.isNotEmpty
                                        // ?Container(

                                        //     margin: const EdgeInsets.only(bottom: 16),
                                        //     decoration: BoxDecoration(
                                        //       borderRadius: BorderRadius.circular(8),
                                        //       color: ConstantColors.cardColor,
                                        //       border:
                                        //           Border.all(color: ConstantColors.borderColor),
                                        //     ),
                                        //     child: ExpansionTile(
                                        //         childrenPadding: EdgeInsets.only(
                                        //           bottom: 16,
                                        //         ),
                                        //         iconColor: ConstantColors.hintColor,
                                        //         collapsedIconColor: ConstantColors.hintColor,
                                        //         initiallyExpanded: false,
                                        //         expandedCrossAxisAlignment:
                                        //             CrossAxisAlignment.start,
                                        //         title: Text(
                                        //           'New Jobs',
                                        //           style: Theme.of(context)
                                        //               .textTheme
                                        //               .headlineMedium,
                                        //         ),
                                        //         children: controller.newJobs.value
                                        //             .map((job) => Column(
                                        //                   crossAxisAlignment:
                                        //                       CrossAxisAlignment.start,
                                        //                   children: [
                                        //                     Container(
                                        //                         padding: EdgeInsets.symmetric(
                                        //                             horizontal: 16),
                                        //                         child: Column(
                                        //                           crossAxisAlignment:
                                        //                               CrossAxisAlignment.start,
                                        //                           children: [
                                        //                             Text(
                                        //                               "${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['from']} - ${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['to']}",
                                        //                               style: Theme.of(context)
                                        //                                   .textTheme
                                        //                                   .titleMedium,
                                        //                             ),
                                        //                             Text(
                                        //                               job.vehicle!.carBrand!.name.toString()+', ' + job.vehicle!.carModel!.name.toString(),
                                        //                               style: TextStyle(
                                        //                                   fontSize: 11,
                                        //                                   fontWeight:
                                        //                                       FontWeight.w400,
                                        //                                   color: ConstantColors
                                        //                                       .primaryColor,
                                        //                                   fontFamily: localization ==
                                        //                                           "en"
                                        //                                       ? GoogleFonts
                                        //                                               .roboto()
                                        //                                           .fontFamily
                                        //                                       : 'DubaiFont'),
                                        //                             ),
                                        //                             SizedBox(
                                        //                               height: 8,
                                        //                             ),
                                        //                             Text(
                                        //                               job.address!.address![0],
                                        //                               style: Theme.of(context)
                                        //                                   .textTheme
                                        //                                   .headlineMedium,
                                        //                             ),
                                        //                             SizedBox(
                                        //                               height: 10,
                                        //                             ),
                                        //                             SingleChildScrollView(
                                        //                               scrollDirection:
                                        //                                   Axis.horizontal,
                                        //                               child: Row(
                                        //                                 mainAxisAlignment:
                                        //                                     MainAxisAlignment
                                        //                                         .spaceBetween,
                                        //                                 mainAxisSize:
                                        //                                     MainAxisSize.min,
                                        //                                 children: [
                                        //                                   ElevatedButton(
                                        //                                     style:
                                        //                                         ElevatedButton
                                        //                                             .styleFrom(
                                        //                                       // fixedSize: Size(95, 32),
                                        //                                       padding:
                                        //                                           EdgeInsets
                                        //                                               .all(12),
                                        //                                       backgroundColor:
                                        //                                           ConstantColors
                                        //                                               .bodyColor4,
                                        //                                       shape:
                                        //                                           RoundedRectangleBorder(
                                        //                                         borderRadius:
                                        //                                             BorderRadius
                                        //                                                 .circular(
                                        //                                                     5),
                                        //                                       ),
                                        //                                     ),
                                        //                                     child: Text(
                                        //                                       'View Details'
                                        //                                           .toUpperCase(),
                                        //                                       style: TextStyle(
                                        //                                         overflow:
                                        //                                             TextOverflow
                                        //                                                 .ellipsis,
                                        //                                         color: ConstantColors
                                        //                                             .cardColor,
                                        //                                         fontSize: 11,
                                        //                                         fontWeight:
                                        //                                             FontWeight
                                        //                                                 .w700,
                                        //                                         fontFamily: localization ==
                                        //                                                 "en"
                                        //                                             ? GoogleFonts
                                        //                                                     .roboto()
                                        //                                                 .fontFamily
                                        //                                             : 'DubaiFont',
                                        //                                       ),
                                        //                                     ),
                                        //                                     onPressed: () => {
                                        //                                       Get.to(()=>ManageJobsScreen(),arguments: {'jobId': job.id})
                                        //                                     },
                                        //                                   ),
                                        //                                   SizedBox(
                                        //                                     width: 10,
                                        //                                   ),
                                        //                                   ElevatedButton(
                                        //                                     style:
                                        //                                         ElevatedButton
                                        //                                             .styleFrom(
                                        //                                       //  fixedSize: Size(117, 32),
                                        //                                       padding:
                                        //                                           EdgeInsets
                                        //                                               .all(12),
                                        //                                       backgroundColor:
                                        //                                           ConstantColors
                                        //                                               .secondaryColor,
                                        //                                       shape:
                                        //                                           RoundedRectangleBorder(
                                        //                                         borderRadius:
                                        //                                             BorderRadius
                                        //                                                 .circular(
                                        //                                                     5),
                                        //                                       ),
                                        //                                     ),
                                        //                                     child: Text(
                                        //                                       'Accept'/* & Assign*/
                                        //                                           .toUpperCase(),
                                        //                                       style: TextStyle(
                                        //                                         overflow:
                                        //                                             TextOverflow
                                        //                                                 .ellipsis,
                                        //                                         color: ConstantColors
                                        //                                             .cardColor,
                                        //                                         fontSize: 11,
                                        //                                         fontWeight:
                                        //                                             FontWeight
                                        //                                                 .w700,
                                        //                                         fontFamily: localization ==
                                        //                                                 "en"
                                        //                                             ? GoogleFonts
                                        //                                                     .roboto()
                                        //                                                 .fontFamily
                                        //                                             : 'DubaiFont',
                                        //                                       ),
                                        //                                     ),
                                        //                                     onPressed: () => {
                                        //                                       controller.changeStatusNewJobs(controller.newJobs.value.indexOf(job),'accepted')
                                        //                                     },
                                        //                                   ),
                                        //                                   SizedBox(
                                        //                                     width: 10,
                                        //                                   ),
                                        //                                   ElevatedButton(
                                        //                                     style:
                                        //                                         ElevatedButton
                                        //                                             .styleFrom(
                                        //                                       //  fixedSize: Size(63, 32),
                                        //                                       padding:
                                        //                                           EdgeInsets
                                        //                                               .all(12),
                                        //                                       backgroundColor:
                                        //                                           ConstantColors
                                        //                                               .errorColor,
                                        //                                       shape:
                                        //                                           RoundedRectangleBorder(
                                        //                                         borderRadius:
                                        //                                             BorderRadius
                                        //                                                 .circular(
                                        //                                                     5),
                                        //                                       ),
                                        //                                     ),
                                        //                                     child: Text(
                                        //                                       'Reject'
                                        //                                           .toUpperCase(),
                                        //                                       style: TextStyle(
                                        //                                         overflow:
                                        //                                             TextOverflow
                                        //                                                 .ellipsis,
                                        //                                         color: ConstantColors
                                        //                                             .cardColor,
                                        //                                         fontSize: 11,
                                        //                                         fontWeight:
                                        //                                             FontWeight
                                        //                                                 .w700,
                                        //                                         fontFamily: localization ==
                                        //                                                 "en"
                                        //                                             ? GoogleFonts
                                        //                                                     .roboto()
                                        //                                                 .fontFamily
                                        //                                             : 'DubaiFont',
                                        //                                       ),
                                        //                                     ),
                                        //                                     onPressed: () => {
                                        //                                      controller.changeStatusNewJobs(controller.newJobs.value.indexOf(job),'rejected')

                                        //                                     },
                                        //                                   ),
                                        //                                 ],
                                        //                               ),
                                        //                             )
                                        //                           ],
                                        //                         )),
                                        //                     controller.newJobs.value.indexOf(job) <
                                        //                             controller.newJobs.value.length -
                                        //                                 1
                                        //                         ? Divider(
                                        //                             height: 32,
                                        //                             color: ConstantColors
                                        //                                 .borderColor,
                                        //                           )
                                        //                         : SizedBox()
                                        //                   ],
                                        //                 ))
                                        //             .toList()))
                                        ? AnimatedContainer(
                                            duration: const Duration(milliseconds: 300),
                                            height: controller.jobsHeight.value,
                                            margin: const EdgeInsets.only(bottom: 16),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: ConstantColors.cardColor,
                                              border: Border.all(
                                                  color: ConstantColors.borderColor),
                                            ),
                                            onEnd: () {
                                              // This function is called when the animation completes
                                              if (controller.jobsIsExpanded.value &&
                                                  !controller.isTileExpanded.value) {
                                                controller.isTileExpanded.value =
                                                    true;
                                              }
                                            },
                                            child: ExpansionTile(
                                              onExpansionChanged: (expanded) {
                                                controller.jobsIsExpanded.value =
                                                    expanded;
                                                if (expanded) {
                                                  controller.jobsHeight.value = 286;
                                                } else {
                                                  controller.jobsHeight.value = 60;
                                                  controller.isTileExpanded.value =
                                                      false;
                                                }
                                              },
                                              iconColor: ConstantColors.hintColor,
                                              collapsedIconColor:
                                                  ConstantColors.hintColor,
                                              initiallyExpanded:
                                                  controller.isTileExpanded.value,
                                              expandedCrossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              title: Text(
                                                'New Jobs'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                              children:
                                                  controller.isTileExpanded.value
                                                      ? [
                                                          Container(
                                                            height:
                                                                200, // Set a height to make the children scrollable
                                                            child:
                                                                SingleChildScrollView(
                                                              child: Column(
                                                                children: controller
                                                                    .newJobs.value
                                                                    .map((job) {
                                                                  return Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Padding(
                                                                        padding: const EdgeInsets
                                                                            .symmetric(
                                                                            horizontal:
                                                                                16.0),
                                                                        child: Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                          children: [
                                                                            Text(
                                                                              "${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['from']} - ${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['to']}",
                                                                              style: Theme.of(context)
                                                                                  .textTheme
                                                                                  .titleMedium,
                                                                            ),
                                                                            Text(
                                                                             job.vehicle!=null
                                                                             ? job.vehicle!.carBrand!.name.toString() +
                                                                                  ', ' +
                                                                                  job.vehicle!.carModel!.name.toString():'',
                                                                              style:
                                                                                  TextStyle(
                                                                                fontSize:
                                                                                    11,
                                                                                fontWeight:
                                                                                    FontWeight.w400,
                                                                                color:
                                                                                    ConstantColors.primaryColor,
                                                                                fontFamily: localization == "en"
                                                                                    ? GoogleFonts.roboto().fontFamily
                                                                                    : 'DubaiFont',
                                                                              ),
                                                                            ),
                                                                            const SizedBox(
                                                                                height:
                                                                                    8),
                                                                            Text(
                                                                              job.address!=null
                                                                              ?job.address!
                                                                                  .address![0]:'',
                                                                              style: Theme.of(context)
                                                                                  .textTheme
                                                                                  .headlineMedium,
                                                                            ),
                                                                            const SizedBox(
                                                                                height:
                                                                                    10),
                                                                            SingleChildScrollView(
                                                                              scrollDirection:
                                                                                  Axis.horizontal,
                                                                              child:
                                                                                  Row(
                                                                                mainAxisAlignment:
                                                                                    MainAxisAlignment.spaceBetween,
                                                                                mainAxisSize:
                                                                                    MainAxisSize.min,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      padding: const EdgeInsets.all(12),
                                                                                      backgroundColor: ConstantColors.bodyColor4,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'View Details'.tr.toUpperCase(),
                                                                                      style: TextStyle(
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        color: ConstantColors.cardColor,
                                                                                        fontSize: 11,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () => {
                                                                                      Get.to(() => ManageJobsScreen(), arguments: {
                                                                                        'jobId': job.id
                                                                                      })
                                                                                    },
                                                                                  ),
                                                                                  const SizedBox(width: 10),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      padding: const EdgeInsets.all(12),
                                                                                      backgroundColor: ConstantColors.secondaryColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Accept'.tr.toUpperCase(),
                                                                                      style: TextStyle(
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        color: ConstantColors.cardColor,
                                                                                        fontSize: 11,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () => {
                                                                                      controller.changeStatusNewJobs(controller.newJobs.value.indexOf(job), 'accepted')
                                                                                    },
                                                                                  ),
                                                                                  const SizedBox(width: 10),
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      padding: const EdgeInsets.all(12),
                                                                                      backgroundColor: ConstantColors.errorColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                      ),
                                                                                    ),
                                                                                    child: Text(
                                                                                      'Reject'.tr.toUpperCase(),
                                                                                      style: TextStyle(
                                                                                        overflow: TextOverflow.ellipsis,
                                                                                        color: ConstantColors.cardColor,
                                                                                        fontSize: 11,
                                                                                        fontWeight: FontWeight.w700,
                                                                                        fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () => {
                                                                                      controller.changeStatusNewJobs(controller.newJobs.value.indexOf(job), 'rejected')
                                                                                    },
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      const Divider(
                                                                        color: ConstantColors
                                                                            .borderColor,
                                                                      ),
                                                                    ],
                                                                  );
                                                                }).toList(),
                                                              ),
                                                            ),
                                                          ),
                                                        ]
                                                      : [],
                                            ),
                                          )
                                        : const SizedBox()
                                  ]),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                                    children: [
                                      Row(
                                        children: [
                                          Text('Overall Rating'.tr.toUpperCase(),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge),
                                      RatingBar.readOnly(
                                      size: 20,
                                      isHalfAllowed: true,
                                      filledIcon: Icons.star,
                                      filledColor: ConstantColors.secondaryColor,
                                      emptyIcon: Icons.star_outline,
                                      emptyColor: ConstantColors.secondaryColor,
                                      halfFilledColor: ConstantColors.secondaryColor,
                                      halfFilledIcon: Icons.star_half,
                                      initialRating:controller.averageReviews.value! ,
                                    ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text('( '+controller.totalReviews!.value.toString()+')',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .displayLarge),
                                        ],
                                      ),
                                      // Text('View All'.toUpperCase(),
                                      //     style: Theme.of(context).textTheme.headlineLarge)
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       mainAxisSize: MainAxisSize.min,
                                      children: controller.reviews
                                          .map((review) => Container(
                                                margin: const EdgeInsetsDirectional.only(
                                                    end: 8),
                                                padding: const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                    color: ConstantColors.cardColor,
                                                    border: Border.all(
                                                        color: ConstantColors
                                                            .borderColor),
                                                    borderRadius:
                                                        BorderRadius.circular(8)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [

                                                      review.customerImage !=
                                                    null || review.customerImage !=
                                                    ''
                                                ? CachedNetworkImage(
                                                    imageUrl: review.customerImage!,
                                                    width: 40,
                                                    height: 40,
                                                    fit: BoxFit.cover,
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                            'assets/images/avatar.png'))
                                                        :Image.asset(
                                                          "assets/images/avatar.png",
                                                          width: 40,
                                                          height: 40,
                                                        ),
                                                        const SizedBox(
                                                          width: 8,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              review.customerName
                                                                  .toString(),
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .labelLarge,
                                                            ),
                                                          RatingBar.readOnly(
                                      size: 20,
                                      isHalfAllowed: true,
                                      filledIcon: Icons.star,
                                      filledColor: ConstantColors.secondaryColor,
                                      emptyIcon: Icons.star_outline,
                                      emptyColor: ConstantColors.secondaryColor,
                                      halfFilledColor: ConstantColors.secondaryColor,
                                      halfFilledIcon: Icons.star_half,
                                      initialRating:review.rating!.toDouble() ,
                                    ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          width: 16,
                                                        ),
                                                        Text(
                                                         review.date!.toString().split(' ')[0],
                                                          style: TextStyle(
                                                              fontSize: 9,
                                                              color: ConstantColors
                                                                  .bodyColor4,
                                                              fontFamily:
                                                                  GoogleFonts.roboto()
                                                                      .fontFamily,
                                                              fontWeight:
                                                                  FontWeight.w600),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Container(
                                                      width: 195,
                                                      child: Text(
                                                        review.comment.toString(),
                                                        style: TextStyle(
                                                            overflow:
                                                                TextOverflow.visible,
                                                            fontSize: 9,
                                                            color: ConstantColors
                                                                .bodyColor3,
                                                            fontFamily:
                                                                GoogleFonts.roboto()
                                                                    .fontFamily,
                                                            fontWeight:
                                                                FontWeight.w600),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                  )
                                ],
                              )
                            ])))),
                 if(controller.showNotification.value)Align(
                   alignment: localization == "en" ? Alignment.topRight:Alignment.topLeft,
                   child: Container(
                     decoration: BoxDecoration(
                       color: ConstantColors.backgroundColor,
                       border: Border.all(
                         width: 2,
                         color: ConstantColors.primaryColor
                       ),
                       borderRadius: const BorderRadiusDirectional.only(
                         topEnd: Radius.circular(0),
                         bottomEnd: Radius.circular(16),
                         bottomStart: Radius.circular(16),
                         topStart: Radius.circular(16)
                       )
                     ),
                     margin: const EdgeInsetsDirectional.only(top: 83, end: 30, start: 10),
                     padding: const EdgeInsets.all(12),
                     child: SingleChildScrollView(
                       child: Column(
                         mainAxisSize: MainAxisSize.min,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         children: [
                           for(int i = 0; i < controller.getNotificationsRequest!.data!.length; i++)...[
                             Padding(
                               padding: EdgeInsets.only(bottom: i==controller.getNotificationsRequest!.data!.length-1 ? 0 : 6),
                               child: GestureDetector(
                                 onTap: () {
                                   Get.to(()=> ManageJobsScreen(), arguments: {
                                     'order_id': controller.getNotificationsRequest!.data![i].orderId,
                                   });
                                 },
                                 child: Container(
                                   padding: const EdgeInsets.symmetric(
                                       vertical: 20, horizontal: 12),
                                   decoration: BoxDecoration(
                                       color: ConstantColors.primaryColor.withOpacity(0.1),
                                       borderRadius: BorderRadius.circular(8)),
                                   child: Row(
                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                     children: [
                                       Row(
                                         children: [
                                           SvgPicture.asset(circle_notifications),
                                           SizedBox(
                                             width: 16,
                                           ),
                                           Column(
                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               Text(
                                                 controller.getNotificationsRequest!.data![i].title??'',
                                                 style: TextStyle(
                                                     fontSize: 11,
                                                     color: ConstantColors.primaryColor,
                                                     fontFamily:
                                                     GoogleFonts.roboto().fontFamily,
                                                     fontWeight: FontWeight.w700),
                                               ),
                                               Text(
                                                 controller.getNotificationsRequest!.data![i].body??'',
                                                 style: TextStyle(
                                                     fontSize: 9,
                                                     color: ConstantColors.primaryColor,
                                                     fontFamily:
                                                     GoogleFonts.roboto().fontFamily,
                                                     fontWeight: FontWeight.w400),
                                               )
                                             ],
                                           )
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ),
                           ],
                           if(controller.getNotificationsRequest!.data!.isEmpty) Text(
                             'No new notifications'.tr,
                             style: TextStyle(
                                 fontSize: 13,
                                 decoration: TextDecoration.none,
                                 color: ConstantColors.primaryColor,
                                 fontFamily:
                                 GoogleFonts.roboto().fontFamily,
                                 fontWeight: FontWeight.w700),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 controller.buttonLoading.value ? const LoadingWidget() : const Row()
          ],
        ),
      ),
    );
  }
}
