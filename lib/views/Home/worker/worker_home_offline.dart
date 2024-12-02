import 'package:autoflex/controllers/Home/worker/workerHomeOffline-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/jobsRadio.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../models/workerHome/woker_orders.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class WorkerHomeOfflineScreen extends StatelessWidget {
  WorkerHomeOfflineScreen({super.key});
  final WorkerHomeOfflineController controller = Get.put(WorkerHomeOfflineController());
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
                leading: IconButton(
                  icon: SvgPicture.asset(menu, color: ConstantColors.bodyColor,),
                  onPressed: () {
                    /*Get.to(() => WorkerMenuScreen());*/
                    toast(message: 'Can not open menu in offline mode'.tr);
                  },
                ),
                title: SvgPicture.asset(logo),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(notificationsRead, color: ConstantColors.bodyColor,),
                    onPressed: () {
                      /*controller.showNotification.value = !controller.showNotification.value;
                      if(controller.showNotification.value) {
                        controller.readAllNotifications();
                      }*/
                      toast(message: 'Can not read notifications in offline mode'.tr);
                    },
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 32),
                      child: Column(children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: controller.jobsTypes
                                .map((tab) => Container(
                              width: MediaQuery.of(context).size.width /
                                  2.3,
                              child: JobsRadio(
                                value: tab,
                                groupValue:
                                controller.selectedTab.value,
                                onChanged: (value) {
                                  controller.selectedTab.value = tab;
                                  controller.getOrders();
                                },
                                title: tab,
                                customIcon: tab == 'Today’s Jobs'.tr
                                    ? 'today'
                                    : 'calendar_month',
                              ),
                            ))
                                .toList(),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: controller.getWorkerOrders.value.data!
                                .map((job) {
                              var index = controller.getWorkerOrders.value.data!
                                  .indexOf(job);
                              bool isExpanded =
                                  controller.expandedStates[index] ?? false;
                              return InkWell(
                                onTap: () {
                                  print(index);
                                  controller.toggleExpansion(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(8),
                                              topRight: Radius.circular(8),
                                              bottomLeft: Radius.circular(
                                                  controller.selectedTab
                                                      .value ==
                                                      'Future Jobs'.tr
                                                      ? 8
                                                      : 0),
                                              bottomRight: Radius.circular(
                                                  controller.selectedTab
                                                      .value ==
                                                      'Future Jobs'.tr
                                                      ? 8
                                                      : 0)),
                                          color: ConstantColors.primaryColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: RichText(
                                                text: TextSpan(
                                                  text:
                                                  'Today '.tr.toUpperCase(),
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                      FontWeight.w400,
                                                      color: ConstantColors
                                                          .cardColor,
                                                      fontFamily:
                                                      localization == "en"
                                                          ? GoogleFonts
                                                          .roboto()
                                                          .fontFamily
                                                          : 'DubaiFont',
                                                      overflow: TextOverflow
                                                          .ellipsis),
                                                  children: <TextSpan>[
                                                    TextSpan(
                                                      text: job.date!
                                                          .toIso8601String()
                                                          .split('T')[0],
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          fontWeight:
                                                          FontWeight.w700,
                                                          color: ConstantColors
                                                              .cardColor,
                                                          fontFamily:
                                                          localization ==
                                                              "en"
                                                              ? GoogleFonts
                                                              .roboto()
                                                              .fontFamily
                                                              : 'DubaiFont',
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            isExpanded
                                                ? const Icon(
                                              Icons.expand_less,
                                              color: ConstantColors
                                                  .cardColor,
                                            )
                                                : Icon(
                                              Icons.expand_more,
                                              color: ConstantColors
                                                  .cardColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 16),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                          // borderRadius: BorderRadius.circular(8),
                                          color: ConstantColors.cardColor,
                                          border: Border.all(
                                              color:
                                              ConstantColors.borderColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: 'Order ID: '.tr,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w400,
                                                              color: ConstantColors
                                                                  .primaryColor,
                                                              fontFamily: localization ==
                                                                  "en"
                                                                  ? GoogleFonts
                                                                  .roboto()
                                                                  .fontFamily
                                                                  : 'DubaiFont',
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: job.id
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                                  color: ConstantColors
                                                                      .primaryColor,
                                                                  fontFamily: localization ==
                                                                      "en"
                                                                      ? GoogleFonts
                                                                      .roboto()
                                                                      .fontFamily
                                                                      : 'DubaiFont',
                                                                  overflow:
                                                                  TextOverflow
                                                                      .ellipsis),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Text(
                                                        job.customerName
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      ConstantColors
                                                          .primaryColor,
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              callWhite),
                                                          Text(
                                                            'CALL'
                                                                .tr
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              color:
                                                              ConstantColors
                                                                  .cardColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                              fontFamily: localization ==
                                                                  "en"
                                                                  ? GoogleFonts
                                                                  .roboto()
                                                                  .fontFamily
                                                                  : 'DubaiFont',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      backgroundColor:
                                                      Color(0xff00DD00),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(
                                                              whatsAppWhite),
                                                          Text(
                                                            'WhatsApp'
                                                                .tr
                                                                .toUpperCase(),
                                                            style: TextStyle(
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              color:
                                                              ConstantColors
                                                                  .cardColor,
                                                              fontSize: 13,
                                                              fontWeight:
                                                              FontWeight
                                                                  .w700,
                                                              fontFamily: localization ==
                                                                  "en"
                                                                  ? GoogleFonts
                                                                  .roboto()
                                                                  .fontFamily
                                                                  : 'DubaiFont',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            isExpanded
                                                ? Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Container(
                                                  padding: EdgeInsets
                                                      .symmetric(
                                                      vertical: 12),
                                                  color:
                                                  Color(0xffE3E4E5),
                                                  child: Row(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .center,
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                    children: [
                                                      SvgPicture.asset(
                                                          wallet),
                                                      SizedBox(
                                                        width: 8,
                                                      ),
                                                      Text(
                                                        job.price
                                                            .toString() +
                                                            ' (' +
                                                            job.paymentMethod
                                                                .toString() +
                                                            ')',
                                                        style: Theme.of(
                                                            context)
                                                            .textTheme
                                                            .headlineSmall,
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        calendar_clock_blue),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          job.date!
                                                              .toIso8601String()
                                                              .split(
                                                              'T')[0],
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                        Text(
                                                          job.date!
                                                              .toIso8601String()
                                                              .split(
                                                              'T')[1]
                                                              .replaceRange(
                                                              5,
                                                              12,
                                                              ''),
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        carSelected),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                          (job.vehicle ??
                                                              Vehicle(
                                                                  carBrand:
                                                                  CarBrand(name: '')))
                                                              .carBrand!
                                                              .name
                                                              .toString(),
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .displayMedium,
                                                        ),
                                                        Text(
                                                          (job.vehicle ??
                                                              Vehicle(
                                                                  carModel:
                                                                  Car(name: '')))
                                                              .carModel!
                                                              .name
                                                              .toString(),
                                                          style: Theme.of(
                                                              context)
                                                              .textTheme
                                                              .headlineSmall,
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                        location_on_blue),
                                                    SizedBox(
                                                      width: 8,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            job.address!
                                                                .address![0],
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .displayMedium,
                                                          ),
                                                          Text(
                                                            job.address!
                                                                .city
                                                                .toString(),
                                                            style: Theme.of(
                                                                context)
                                                                .textTheme
                                                                .headlineSmall,
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    SvgPicture.asset(
                                                        directions)
                                                  ],
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Text(
                                                  'Service Description'
                                                      .tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Column(
                                                  children: ((job.product ??
                                                      Product(
                                                          description: []))
                                                      .description)!
                                                      .map<Widget>(
                                                          (service) =>
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom:
                                                                4),
                                                            child:
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    checkCircle),
                                                                SizedBox(
                                                                  width:
                                                                  8,
                                                                ),
                                                                Expanded(
                                                                    child: Text(
                                                                      service,
                                                                      style:
                                                                      Theme.of(context).textTheme.displayMedium,
                                                                    ))
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Text(
                                                  'Additional Information '
                                                      .tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                /*Column(children:[
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(steppers_blue),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('Wax, Trash bag, Tissue pack, Perfuming, Floor matscasing'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      SizedBox(height: 4,),
                                                       Row(
                                                        children: [
                                                          SvgPicture.asset(flash_off),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('No power outlet required'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      SizedBox(height: 4,),
                                                       Row(
                                                        children: [
                                                          SvgPicture.asset(schedule_blue),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('Duration: 1 HOUR'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      ]),*/
                                                Column(
                                                  children: ((job.product ??
                                                      Product(
                                                          additionalInformation: []))
                                                      .additionalInformation)!
                                                      .map<Widget>(
                                                          (service) =>
                                                          Container(
                                                            margin: EdgeInsets.only(
                                                                bottom:
                                                                4),
                                                            child:
                                                            Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    checkCircle),
                                                                SizedBox(
                                                                  width:
                                                                  8,
                                                                ),
                                                                Expanded(
                                                                    child: Text(
                                                                      service,
                                                                      style:
                                                                      Theme.of(context).textTheme.displayMedium,
                                                                    ))
                                                              ],
                                                            ),
                                                          ))
                                                      .toList(),
                                                ),
                                                const Divider(
                                                  color: ConstantColors
                                                      .borderColor,
                                                  height: 24,
                                                ),
                                                Text(
                                                  'Add-ons'.tr,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                SizedBox(
                                                  height: 16,
                                                ),
                                                Row(
                                                  children: [
                                                    ...(job.product ??
                                                        Product(
                                                            addOns: []))
                                                        .addOns!
                                                        .map<Widget>(
                                                          (addOn) {
                                                        int index = (job
                                                            .product ??
                                                            Product(
                                                                addOns: []))
                                                            .addOns!
                                                            .indexOf(
                                                            addOn);
                                                        return Padding(
                                                          padding: EdgeInsetsDirectional.only(
                                                              end: index ==
                                                                  (job.product ?? Product(addOns: [])).addOns!.length -
                                                                      1
                                                                  ? 0
                                                                  : 12),
                                                          child:
                                                          ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              backgroundColor:
                                                              ConstantColors
                                                                  .secondaryColor,
                                                              shape:
                                                              RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius.circular(
                                                                    8),
                                                              ),
                                                            ),
                                                            child:
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                vertical:
                                                                8,
                                                              ),
                                                              child: Text(
                                                                addOn
                                                                    .name!,
                                                                style:
                                                                TextStyle(
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  color: ConstantColors
                                                                      .cardColor,
                                                                  fontSize:
                                                                  15,
                                                                  fontWeight:
                                                                  FontWeight.w900,
                                                                  fontFamily: localization ==
                                                                      "en"
                                                                      ? GoogleFonts.roboto().fontFamily
                                                                      : 'DubaiFont',
                                                                ),
                                                              ),
                                                            ),
                                                            onPressed:
                                                                () => {},
                                                          ),
                                                        );
                                                      },
                                                    ).toList()
                                                  ],
                                                )
                                              ],
                                            )
                                                : SizedBox()
                                          ],
                                        ),
                                      ),
                                      if (controller.selectedTab.value !=
                                          'Future Jobs'.tr)
                                        InkWell(
                                          onTap: () => changeStatusBottomSheet(
                                              context, job.id),
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                  Radius.circular(8),
                                                  bottomRight:
                                                  Radius.circular(8)),
                                              color:
                                              ConstantColors.secondaryColor,
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Update Job Status'
                                                    .tr
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700,
                                                    color: ConstantColors
                                                        .cardColor,
                                                    fontFamily: localization ==
                                                        "en"
                                                        ? GoogleFonts.roboto()
                                                        .fontFamily
                                                        : 'DubaiFont',
                                                    overflow:
                                                    TextOverflow.ellipsis),
                                              ),
                                            ),
                                          ),
                                        )
                                    ],
                                  ),
                                ),
                              );
                            }).toList()) /*Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: controller.todayJobs.map((job) {
                              var index = controller.todayJobs.indexOf(job);
                              bool isExpanded =
                                  controller.expandedStates[index] ?? false;
                              return InkWell(
                                onTap: () {
                                  controller.toggleExpansion(index);
                                },
                                child: Container(
                                  margin: EdgeInsets.only(bottom: 16),
                                  child: Column(

                                    children: [
                                      Container(
                                    padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.only(topLeft: Radius.circular(8),topRight: Radius.circular(8)),
                                          color: ConstantColors.primaryColor,

                                        ),
                                        child: Row(
                                          children: [
                                         Expanded(
                                           child: RichText(
                                                          text: TextSpan(
                                                            text: job['date']!.toString().split(' ')[0].toUpperCase(),
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight: FontWeight.w400,
                                                                color: ConstantColors
                                                                    .cardColor,
                                                                fontFamily: localization ==
                                                                        "en"
                                                                    ? GoogleFonts.roboto()
                                                                        .fontFamily
                                                                    : 'DubaiFont',
                                                                overflow:
                                                                    TextOverflow.ellipsis),
                                                            children: <TextSpan>[
                                                              TextSpan(text: ' '),
                                                              TextSpan(
                                                                text: job['time']
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    fontSize: 17,
                                                                    fontWeight:
                                                                        FontWeight.w700,
                                                                    color: ConstantColors
                                                                        .cardColor,
                                                                    fontFamily:
                                                                        localization == "en"
                                                                            ? GoogleFonts
                                                                                    .roboto()
                                                                                .fontFamily
                                                                            : 'DubaiFont',
                                                                    overflow: TextOverflow
                                                                        .ellipsis),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                         ),
                                             isExpanded
                                                    ? const Icon(
                                                        Icons.expand_less,
                                                        color: ConstantColors.cardColor,
                                                      )
                                                    : Icon(
                                                        Icons.expand_more,
                                                        color: ConstantColors.cardColor,
                                                      ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        // margin: EdgeInsets.only(bottom: 16),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 16, horizontal: 24),
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8),bottomRight: Radius.circular(8)),

                                          color: ConstantColors.cardColor,
                                          border: Border.all(
                                              color: ConstantColors.borderColor),
                                        ),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      RichText(
                                                        text: TextSpan(
                                                          text: 'Order ID: '.tr,
                                                          style: TextStyle(
                                                              fontSize: 11,
                                                              fontWeight: FontWeight.w400,
                                                              color: ConstantColors
                                                                  .primaryColor,
                                                              fontFamily: localization ==
                                                                      "en"
                                                                  ? GoogleFonts.roboto()
                                                                      .fontFamily
                                                                  : 'DubaiFont',
                                                              overflow:
                                                                  TextOverflow.ellipsis),
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: job['orderId']
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 11,
                                                                  fontWeight:
                                                                      FontWeight.w700,
                                                                  color: ConstantColors
                                                                      .primaryColor,
                                                                  fontFamily:
                                                                      localization == "en"
                                                                          ? GoogleFonts
                                                                                  .roboto()
                                                                              .fontFamily
                                                                          : 'DubaiFont',
                                                                  overflow: TextOverflow
                                                                      .ellipsis),
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      Text(
                                                        job['name'].toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleSmall,
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                              ],
                                            ),
                                            SizedBox(
                                              height: 12,
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(

                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [

                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          ConstantColors.primaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(callWhite),
                                                          Text(
                                                            'CALL'.tr.toUpperCase(),
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                              color: ConstantColors
                                                                  .cardColor,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w700,
                                                              fontFamily: localization ==
                                                                      "en"
                                                                  ? GoogleFonts.roboto()
                                                                      .fontFamily
                                                                  : 'DubaiFont',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Color(0xff00DD00),
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          SvgPicture.asset(whatsAppWhite),
                                                          Text(
                                                            'WhatsApp'.tr.toUpperCase(),
                                                            style: TextStyle(
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                              color: ConstantColors
                                                                  .cardColor,
                                                              fontSize: 13,
                                                              fontWeight: FontWeight.w700,
                                                              fontFamily: localization ==
                                                                      "en"
                                                                  ? GoogleFonts.roboto()
                                                                      .fontFamily
                                                                  : 'DubaiFont',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                ],
                                              ),
                                            ),
                                            isExpanded
                                                ? Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start
                                                  ,
                                                    children: [
                                                      Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Container(
                                                        padding: EdgeInsets.symmetric(
                                                            vertical: 12),
                                                        color: Color(0xffE3E4E5),
                                                        child: Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.center,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment.center,
                                                          children: [
                                                            SvgPicture.asset(wallet),
                                                            SizedBox(
                                                              width: 8,
                                                            ),
                                                            Text(
                                                              job['price'].toString() +
                                                                  ' (' +
                                                                  job['payType']
                                                                      .toString() +
                                                                  ')',
                                                              style: Theme.of(context)
                                                                  .textTheme
                                                                  .headlineSmall,
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(calendar_clock_blue),
                                                          SizedBox(width: 8,),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(job['date'].toString(),style: Theme.of(context).textTheme.displayMedium,),
                                                              Text(job['time'].toString(),style: Theme.of(context).textTheme.headlineSmall,)

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(carSelected),
                                                          SizedBox(width: 8,),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Text(job['carType'].toString(),style: Theme.of(context).textTheme.displayMedium,),
                                                              Text(job['model'].toString(),style: Theme.of(context).textTheme.headlineSmall,)

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                      const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(location_on_blue),
                                                          SizedBox(width: 8,),
                                                          Expanded(
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text(job['address'].toString(),style: Theme.of(context).textTheme.displayMedium,),
                                                                Text(job['place'].toString(),style: Theme.of(context).textTheme.headlineSmall,)

                                                              ],
                                                            ),
                                                          ),
                                                          SvgPicture.asset(directions)
                                                        ],
                                                      ),
                                                       const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Text('Service Description'.tr,style: Theme.of(context).textTheme.titleSmall,),
                                                      SizedBox(height: 16,),
                                                      Column(children:(job['services'] as List).map<Widget>((service) =>
                                                      Container(
                                                        margin: EdgeInsets.only(bottom: 4),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(checkCircle),
                                                            SizedBox(width: 8,),
                                                            Expanded(child: Text(service,style: Theme.of(context).textTheme.displayMedium,))
                                                          ],
                                                        ),
                                                      )).toList(),),
                                      const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                      Text('Additional Information '.tr,style: Theme.of(context).textTheme.titleSmall,),
                                                      SizedBox(height: 16,),
                                                      Column(children:[
                                                      Row(
                                                        children: [
                                                          SvgPicture.asset(steppers_blue),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('Wax, Trash bag, Tissue pack, Perfuming, Floor matscasing'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      SizedBox(height: 4,),
                                                       Row(
                                                        children: [
                                                          SvgPicture.asset(flash_off),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('No power outlet required'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      SizedBox(height: 4,),
                                                       Row(
                                                        children: [
                                                          SvgPicture.asset(schedule_blue),
                                                          SizedBox(width: 8,),
                                                          Expanded(child: Text('Duration: 1 HOUR'.tr,style: Theme.of(context).textTheme.displayMedium,))
                                                        ],
                                                      ),
                                                      ]),
                                      const Divider(
                                                        color: ConstantColors.borderColor,
                                                        height: 24,
                                                      ),
                                                       Text('Add-ons'.tr,style: Theme.of(context).textTheme.titleSmall,),
                                      SizedBox(height: 16,),
                                      Row(
                                        children: [
                                             ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          ConstantColors.secondaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Text(
                                                        'Wax'.tr.toUpperCase(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          color: ConstantColors.cardColor,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w900,
                                                          fontFamily: localization == "en"
                                                              ? GoogleFonts.roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont',
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),
                                                  SizedBox(
                                                    width: 12,
                                                  ),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          ConstantColors.secondaryColor,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.circular(8),
                                                      ),
                                                    ),
                                                    child: Padding(
                                                      padding: const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                      ),
                                                      child: Text(
                                                        'Body Polish'.tr.toUpperCase(),
                                                        style: TextStyle(
                                                          overflow: TextOverflow.ellipsis,
                                                          color: ConstantColors.cardColor,
                                                          fontSize: 15,
                                                          fontWeight: FontWeight.w900,
                                                          fontFamily: localization == "en"
                                                              ? GoogleFonts.roboto()
                                                                  .fontFamily
                                                              : 'DubaiFont',
                                                        ),
                                                      ),
                                                    ),
                                                    onPressed: () => {},
                                                  ),

                                        ],
                                      )

                                                    ],
                                                  )
                                                : SizedBox()
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                              );
                            }).toList())*/
                      ])))),
          /*if(controller.showNotification.value)Align(
            child: Container(
              decoration: BoxDecoration(
                  color: ConstantColors.backgroundColor,
                  border: Border.all(
                      width: 2,
                      color: ConstantColors.primaryColor
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                      topEnd: Radius.circular(0),
                      bottomEnd: Radius.circular(16),
                      bottomStart: Radius.circular(16),
                      topStart: Radius.circular(16)
                  )
              ),
              margin: EdgeInsetsDirectional.only(top: 83, end: 30, start: 10),
              padding: EdgeInsets.all(12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for(int i = 0; i < controller.getNotificationsRequest!.data!.length; i++)...[
                      Container(
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
                    ]
                  ],
                ),
              ),
            ),
            alignment: localization == "en" ? Alignment.topRight:Alignment.topLeft,
          ),*/
        ],
      ),
    );
  }

  Future<dynamic> changeStatusBottomSheet(BuildContext context, id) {
    return showModalBottomSheet(
        constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width - 30, maxHeight: 322),
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
                      if (DateTime.now().isAfter(controller
                          .getWorkerOrders
                          .value
                          .data![
                      controller.getWorkerOrders.value.data!.indexWhere(
                            (element) => element.id == id,
                      )]
                          .date!)) {
                        controller.changeStatus(id, 'On the Way'.toLowerCase());
                      } else {
                        toast(
                            message:
                            'Can not change status until reached the order time'
                                .tr);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('On the Way'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(
                            aod_watch,
                            color: controller
                                .getWorkerOrders
                                .value
                                .data![controller
                                .getWorkerOrders.value.data!
                                .indexWhere(
                                  (element) => element.id == id,
                            )]
                                .status ==
                                'On the Way'.toLowerCase()
                                ? ConstantColors.secondaryColor
                                : ConstantColors.bodyColor,
                          )
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
                      if (DateTime.now().isAfter(controller
                          .getWorkerOrders
                          .value
                          .data![
                      controller.getWorkerOrders.value.data!.indexWhere(
                            (element) => element.id == id,
                      )]
                          .date!)) {
                        controller.changeStatus(id, 'Reached'.toLowerCase());
                      } else {
                        toast(
                            message:
                            'Can not change status until reached the order time'
                                .tr);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Reached'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(
                            where_to_vote,
                            color: controller
                                .getWorkerOrders
                                .value
                                .data![controller
                                .getWorkerOrders.value.data!
                                .indexWhere(
                                  (element) => element.id == id,
                            )]
                                .status ==
                                'Reached'.toLowerCase()
                                ? ConstantColors.secondaryColor
                                : ConstantColors.bodyColor,
                          )
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
                      if (DateTime.now().isAfter(controller
                          .getWorkerOrders
                          .value
                          .data![
                      controller.getWorkerOrders.value.data!.indexWhere(
                            (element) => element.id == id,
                      )]
                          .date!)) {
                        controller.changeStatus(
                            id, 'Job Started / Working'.toLowerCase());
                      } else {
                        toast(
                            message:
                            'Can not change status until reached the order time'
                                .tr);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Job Started / Working'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(
                            published_with_changes,
                            color: controller
                                .getWorkerOrders
                                .value
                                .data![controller
                                .getWorkerOrders.value.data!
                                .indexWhere(
                                  (element) => element.id == id,
                            )]
                                .status ==
                                'Job Started / Working'.toLowerCase()
                                ? ConstantColors.secondaryColor
                                : ConstantColors.bodyColor,
                          )
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
                      if (DateTime.now().isAfter(controller
                          .getWorkerOrders
                          .value
                          .data![
                      controller.getWorkerOrders.value.data!.indexWhere(
                            (element) => element.id == id,
                      )]
                          .date!)) {
                        controller.changeStatus(id, 'Completed'.toLowerCase());
                      } else {
                        toast(
                            message:
                            'Can not change status until reached the order time'
                                .tr);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Completed'.tr,
                              style: Theme.of(context).textTheme.displayLarge),
                          SvgPicture.asset(
                            check_circle_gray,
                            color: controller
                                .getWorkerOrders
                                .value
                                .data![controller
                                .getWorkerOrders.value.data!
                                .indexWhere(
                                  (element) => element.id == id,
                            )]
                                .status ==
                                'Completed'.toLowerCase()
                                ? ConstantColors.secondaryColor
                                : ConstantColors.bodyColor,
                          )
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
