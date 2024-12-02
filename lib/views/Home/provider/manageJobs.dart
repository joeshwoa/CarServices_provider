import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/controllers/Home/manageJobs-controller.dart';
import 'package:autoflex/models/products/addServiceForm.dart';
import 'package:autoflex/shared/components/jobsRadio.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../main.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class ManageJobsScreen extends StatelessWidget {
  ManageJobsScreen({super.key});
  final ManageJobsController controller = Get.put(ManageJobsController());

  final ScrollController scrollController = ScrollController();

  /*scrollToOrderById(int index) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.jumpTo(index*1.0);
    });
  }*/
  bool first = true;
  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if(first && controller.getAllOrdersRequest.data!.isNotEmpty) {
          first = false;
          if(controller.selectedOrder != -1) {
            scrollController.jumpTo(controller.selectedOrder*170.0);
          }
        }
        return Scaffold(
          backgroundColor: ConstantColors.backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16.0),
              child: Text('Manage Jobs'.tr.toUpperCase(),
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
            controller: scrollController,
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
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: controller.jobsTabs
                                  .map((tab) => Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3.5,
                                        child: JobsRadio(
                                          value: tab,
                                          groupValue:
                                              controller.selectedTab.value,
                                          onChanged: (value) {
                                            controller.selectedTab.value = tab;
                                          },
                                          title: tab,
                                          customIcon: tab == 'Pending'.tr
                                              ? 'calendar_clock'
                                              : tab == 'Assigned'.tr
                                                  ? 'person_check'
                                                  : 'reset',
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          controller.selectedTab.value == 'Pending'.tr ||
                                  controller.selectedTab.value == 'accepted'
                              ? controller.pendingJobs.isEmpty
                                  ? Center(
                                      child: Text(
                                        'NO ORDERS FOUND'.tr,
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 14),
                                      ),
                                    )
                                  : Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children:
                                          controller.pendingJobs.map((job) {
                                        var index =
                                            controller.pendingJobs.indexOf(job);
                                        bool isExpanded =
                                            controller.expandedStates[index] ??
                                                false;
                                        return InkWell(
                                          onTap: () {
                                            controller.toggleExpansion(index);
                                          },
                                          child: Container(
                                            margin: const EdgeInsets.only(
                                                bottom: 16),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 16, horizontal: 24),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: ConstantColors.cardColor,
                                              border: Border.all(
                                                  color: ConstantColors
                                                      .borderColor),
                                            ),
                                            child: Column(
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
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          RichText(
                                                            text: TextSpan(
                                                              text: 'Order ID: '
                                                                  .tr,
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
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      color: ConstantColors
                                                                          .primaryColor,
                                                                      fontFamily: localization ==
                                                                              "en"
                                                                          ? GoogleFonts.roboto()
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
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    isExpanded
                                                        ? const Icon(
                                                            Icons.expand_less,
                                                            color:
                                                                ConstantColors
                                                                    .hintColor,
                                                          )
                                                        : const Icon(
                                                            Icons.expand_more,
                                                            color:
                                                                ConstantColors
                                                                    .hintColor,
                                                          ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 12,
                                                ),
                                                SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    // mainAxisAlignment:
                                                    // MainAxisAlignment.spaceBetween,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      12),
                                                          fixedSize: const Size(
                                                              86, 36),
                                                          backgroundColor:
                                                              ConstantColors
                                                                  .secondaryColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          'Assign'
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
                                                                FontWeight.w700,
                                                            fontFamily: localization ==
                                                                    "en"
                                                                ? GoogleFonts
                                                                        .roboto()
                                                                    .fontFamily
                                                                : 'DubaiFont',
                                                          ),
                                                        ),
                                                        onPressed: () async => {
                                                          await controller
                                                              .getWorkers(
                                                                  job.date, ""),
                                                          showDialog(
                                                              context: context,
                                                              builder:
                                                                  (_) => Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          Dialog(
                                                                              insetPadding: const EdgeInsets.symmetric(horizontal: 16),
                                                                              backgroundColor: ConstantColors.cardColor,
                                                                              shape: const RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.all(
                                                                                  Radius.circular(10.0),
                                                                                ),
                                                                              ),
                                                                              child: Container(
                                                                                width: double.infinity,
                                                                                child: SingleChildScrollView(
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                                                    children: controller
                                                                                            .popUpLoading.value
                                                                                        ? [
                                                                                            const Center(child: CircularProgressIndicator())
                                                                                          ]
                                                                                        : controller.workers.map((worker) {
                                                                                            var index = controller.workers.indexOf(worker);
                                                                                            return Column(
                                                                                              children: [
                                                                                                InkWell(
                                                                                                  onTap: () => {
                                                                                                    controller.assignWorker(job.id, worker.id)
                                                                                                  },
                                                                                                  child: Padding(
                                                                                                    padding: const EdgeInsets.all(16.0),
                                                                                                    child: Row(
                                                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                                                                      children: [
                                                                                                        worker.image != null && worker.image!.isNotEmpty
                                                                                                            ? CachedNetworkImage(
                                                                                                                imageUrl: worker.image!,
                                                                                                                width: 40,
                                                                                                                height: 40,
                                                                                                              )
                                                                                                            : Image.asset(
                                                                                                                "assets/images/avatar.png",
                                                                                                                width: 40,
                                                                                                                height: 40,
                                                                                                              ),
                                                                                                        const SizedBox(
                                                                                                          width: 16,
                                                                                                        ),
                                                                                                        Column(
                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                                          children: [
                                                                                                            Text(
                                                                                                              worker.fullName.toString(),
                                                                                                              style: Theme.of(context).textTheme.displayLarge,
                                                                                                            ),
                                                                                                            // Text(worker['jobsNumber'].toString()+' Job Assigned for the same day',style: Theme.of(context).textTheme.headlineLarge)
                                                                                                          ],
                                                                                                        )
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ),
                                                                                                index != controller.workers.length - 1
                                                                                                    ? const Divider(
                                                                                                        height: 1,
                                                                                                        color: Color.fromARGB(59, 57, 58, 59),
                                                                                                      )
                                                                                                    : const SizedBox(),
                                                                                              ],
                                                                                            );
                                                                                          }).toList(),
                                                                                  ),
                                                                                ),
                                                                              )),

                                                                          //  SizedBox(height: 12,),
                                                                          Dialog(
                                                                            insetPadding:
                                                                                const EdgeInsets.all(16),
                                                                            backgroundColor:
                                                                                ConstantColors.cardColor,
                                                                            shape:
                                                                                const RoundedRectangleBorder(
                                                                              borderRadius: BorderRadius.all(
                                                                                Radius.circular(10.0),
                                                                              ),
                                                                            ),
                                                                            child:
                                                                                Padding(
                                                                              padding: const EdgeInsets.symmetric(vertical: 16.0),
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
                                                                                      fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ))
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      12),
                                                          fixedSize: Get.locale!
                                                                      .countryCode ==
                                                                  'en'
                                                              ? const Size(
                                                                  74, 36)
                                                              : const Size(
                                                                  80, 36),
                                                          backgroundColor:
                                                              ConstantColors
                                                                  .primaryColor,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            SvgPicture.asset(
                                                                callWhite),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'Call'.tr,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: ConstantColors
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
                                                            ),
                                                          ],
                                                        ),
                                                        onPressed: () async =>
                                                            await FlutterPhoneDirectCaller
                                                                .callNumber(job
                                                                    .customerPhone!
                                                                    .toString()),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 8,
                                                                  horizontal:
                                                                      12),
                                                          fixedSize: const Size(
                                                              111, 36),
                                                          backgroundColor:
                                                              const Color(
                                                                  0xff00DD00),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                          ),
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            SvgPicture.asset(
                                                                whatsAppWhite),
                                                            const SizedBox(
                                                              width: 2,
                                                            ),
                                                            Expanded(
                                                              child: Text(
                                                                'WhatsApp'.tr,
                                                                style:
                                                                    TextStyle(
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  color: ConstantColors
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
                                                            ),
                                                          ],
                                                        ),
                                                        onPressed: () async {
                                                          await launch(
                                                              'whatsapp://send?phone=${job.customerWhatsappNumber}');
                                                        },
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
                                                                    vertical:
                                                                        12),
                                                            color: Color(
                                                                0xffE3E4E5),
                                                            child: Row(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SvgPicture
                                                                    .asset(
                                                                        wallet),
                                                                const SizedBox(
                                                                  width: 8,
                                                                ),
                                                                Text(
                                                                  '${'AED'.tr} ${job.price}${job.paymentMethod == 'cashondelivery' ? ' (Cash on Delivery)'.tr : ' (Pay By Card)'.tr}',
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
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    job.day.toString() +
                                                                        ' ' +
                                                                        job.date!
                                                                            .split(' ')[0]
                                                                            .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Text(
                                                                    "${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['from']} - ${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['to']}"
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
                                                                  carSelected),
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    job.vehicle !=
                                                                            null
                                                                        ? job.vehicle!.carBrand!.name.toString() +
                                                                            ' ' +
                                                                            job.vehicle!.carModel!.name.toString() +
                                                                            "\n" +
                                                                            job.vehicle!.year!.toString() +
                                                                            ', ' +
                                                                            job.vehicle!.color!.toString() +
                                                                            ' ( ' +
                                                                            job.vehicle!.gearType!.toString() +
                                                                            ' Gear )'.tr
                                                                        : '',
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .displayMedium,
                                                                  ),
                                                                  Text(
                                                                    job.vehicle !=
                                                                            null
                                                                        ? job.vehicle!.plateCode.toString() +
                                                                            ' - ' +
                                                                            job.vehicle!.plateNumber.toString()
                                                                        : '',
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
                                                              const SizedBox(
                                                                width: 8,
                                                              ),
                                                              Expanded(
                                                                child: Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Text(
                                                                      job.address !=
                                                                              null
                                                                          ? job
                                                                              .address!
                                                                              .address![0]
                                                                              .toString()
                                                                          : '',
                                                                      style: Theme.of(
                                                                              context)
                                                                          .textTheme
                                                                          .displayMedium,
                                                                    ),
                                                                    Text(
                                                                      '',
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
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          // Column(children:(job['services'] as List).map<Widget>((service) =>
                                                          // Container(
                                                          //   margin: EdgeInsets.only(bottom: 4),
                                                          //   child: Row(
                                                          //     children: [
                                                          //       SvgPicture.asset(checkCircle),
                                                          //       SizedBox(width: 8,),
                                                          //       Expanded(child: Text(service,style: Theme.of(context).textTheme.displayMedium,))
                                                          //     ],
                                                          //   ),
                                                          // )).toList(),),
                                                          const Divider(
                                                            color: ConstantColors
                                                                .borderColor,
                                                            height: 24,
                                                          ),
                                                          Text(
                                                            'Additional Information '
                                                                .tr,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          // Column(children:[
                                                          // Row(
                                                          //   children: [
                                                          //     SvgPicture.asset(steppers_blue),
                                                          //     SizedBox(width: 8,),
                                                          //     Expanded(child: Text('Wax, Trash bag, Tissue pack, Perfuming, Floor matscasing',style: Theme.of(context).textTheme.displayMedium,))
                                                          //   ],
                                                          // ),
                                                          // SizedBox(height: 4,),
                                                          //  Row(
                                                          //   children: [
                                                          //     SvgPicture.asset(flash_off),
                                                          //     SizedBox(width: 8,),
                                                          //     Expanded(child: Text('No power outlet required',style: Theme.of(context).textTheme.displayMedium,))
                                                          //   ],
                                                          // ),
                                                          // SizedBox(height: 4,),
                                                          //  Row(
                                                          //   children: [
                                                          //     SvgPicture.asset(schedule_blue),
                                                          //     SizedBox(width: 8,),
                                                          //     Expanded(child: Text('Duration: 1 HOUR',style: Theme.of(context).textTheme.displayMedium,))
                                                          //   ],
                                                          // ),
                                                          // ]),

                                                          const Divider(
                                                            color: ConstantColors
                                                                .borderColor,
                                                            height: 24,
                                                          ),
                                                          Text(
                                                            'Add-ons'.tr,
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .titleSmall,
                                                          ),
                                                          const SizedBox(
                                                            height: 16,
                                                          ),
                                                          Row(
                                                            children: job
                                                                .addOns!
                                                                .map(
                                                                    (addOn) =>
                                                                        Row(
                                                                          children: [
                                                                            ElevatedButton(
                                                                              style: ElevatedButton.styleFrom(
                                                                                backgroundColor: ConstantColors.secondaryColor,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.symmetric(
                                                                                  vertical: 8,
                                                                                ),
                                                                                child: Text(
                                                                                  addOn.name!.toUpperCase(),
                                                                                  style: TextStyle(
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    color: ConstantColors.cardColor,
                                                                                    fontSize: 15,
                                                                                    fontWeight: FontWeight.w900,
                                                                                    fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              onPressed: () => {},
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 12,
                                                                            )
                                                                          ],
                                                                        ))
                                                                .toList(), // Convert Iterable to List here
                                                          )
                                                        ],
                                                      )
                                                    : const SizedBox()
                                              ],
                                            ),
                                          ),
                                        );
                                      }).toList())
                              : controller.selectedTab.value == 'Assigned'.tr
                                  ? controller.assignedJobs.isEmpty
                                      ? Center(
                                          child: Text(
                                            'NO ORDERS FOUND'.tr,
                                            style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14),
                                          ),
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: controller.assignedJobs
                                              .map((job) {
                                            var index = controller.assignedJobs
                                                .indexOf(job);

                                            bool isExpanded = controller
                                                    .expandedStates[index] ??
                                                false;
                                            return InkWell(
                                              onTap: () {
                                                controller
                                                    .toggleExpansion(index);
                                              },
                                              child: Container(
                                                margin: const EdgeInsets.only(
                                                    bottom: 16),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 16,
                                                        horizontal: 24),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  color:
                                                      ConstantColors.cardColor,
                                                  border: Border.all(
                                                      color: ConstantColors
                                                          .borderColor),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              RichText(
                                                                text: TextSpan(
                                                                  text:
                                                                      'Order ID: '
                                                                          .tr,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          11,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      color: ConstantColors
                                                                          .primaryColor,
                                                                      fontFamily: localization ==
                                                                              "en"
                                                                          ? GoogleFonts.roboto()
                                                                              .fontFamily
                                                                          : 'DubaiFont',
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis),
                                                                  children: <TextSpan>[
                                                                    TextSpan(
                                                                      text: job
                                                                          .id
                                                                          .toString(),
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w700,
                                                                          color: ConstantColors
                                                                              .primaryColor,
                                                                          fontFamily: localization == "en"
                                                                              ? GoogleFonts.roboto()
                                                                                  .fontFamily
                                                                              : 'DubaiFont',
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Text(
                                                                job.customerName
                                                                    .toString(),
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        isExpanded
                                                            ? const Icon(
                                                                Icons
                                                                    .expand_less,
                                                                color: ConstantColors
                                                                    .hintColor,
                                                              )
                                                            : const Icon(
                                                                Icons
                                                                    .expand_more,
                                                                color: ConstantColors
                                                                    .hintColor,
                                                              ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          // ElevatedButton(
                                                          //   style: ElevatedButton
                                                          //       .styleFrom(
                                                          //     padding: EdgeInsets
                                                          //         .symmetric(
                                                          //             vertical: 8,
                                                          //             horizontal:
                                                          //                 12),
                                                          //     fixedSize:
                                                          //         Size(86, 36),
                                                          //     backgroundColor:
                                                          //         ConstantColors
                                                          //             .secondaryColor,
                                                          //     shape:
                                                          //         RoundedRectangleBorder(
                                                          //       borderRadius:
                                                          //           BorderRadius
                                                          //               .circular(
                                                          //                   8),
                                                          //     ),
                                                          //   ),
                                                          //   child: Text(
                                                          //     'Assign'
                                                          //         .toUpperCase(),
                                                          //     style: TextStyle(
                                                          //       overflow:
                                                          //           TextOverflow
                                                          //               .ellipsis,
                                                          //       color:
                                                          //           ConstantColors
                                                          //               .cardColor,
                                                          //       fontSize: 13,
                                                          //       fontWeight:
                                                          //           FontWeight.w700,
                                                          //       fontFamily: localization ==
                                                          //               "en"
                                                          //           ? GoogleFonts
                                                          //                   .roboto()
                                                          //               .fontFamily
                                                          //           : 'DubaiFont',
                                                          //     ),
                                                          //   ),
                                                          //   onPressed: () async => {
                                                          //     await controller
                                                          //         .getWorkers(
                                                          //             job.date, ""),
                                                          //     showDialog(
                                                          //         context: context,
                                                          //         builder:
                                                          //             (_) => Column(
                                                          //                   mainAxisAlignment:
                                                          //                       MainAxisAlignment.center,
                                                          //                   children: [
                                                          //                     Dialog(
                                                          //                         insetPadding: EdgeInsets.symmetric(horizontal: 16),
                                                          //                         backgroundColor: ConstantColors.cardColor,
                                                          //                         shape: const RoundedRectangleBorder(
                                                          //                           borderRadius: BorderRadius.all(
                                                          //                             Radius.circular(10.0),
                                                          //                           ),
                                                          //                         ),
                                                          //                         child: Container(
                                                          //                           width: double.infinity,
                                                          //                           child: SingleChildScrollView(
                                                          //                             child: Column(
                                                          //                               crossAxisAlignment: CrossAxisAlignment.start,
                                                          //                               mainAxisAlignment: MainAxisAlignment.start,
                                                          //                               children: controller.workers.map((worker) {
                                                          //                                 var index = controller.workers.indexOf(worker);
                                                          //                                 return Column(
                                                          //                                   children: [
                                                          //                                     InkWell(
                                                          //                                       child: Padding(
                                                          //                                         padding: const EdgeInsets.all(16.0),
                                                          //                                         child: Row(
                                                          //                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                          //                                           mainAxisAlignment: MainAxisAlignment.start,
                                                          //                                           children: [
                                                          //                                             worker.image != null && worker.image!.isNotEmpty
                                                          //                                                 ? CachedNetworkImage(
                                                          //                                                     imageUrl: worker.image!,
                                                          //                                                     width: 40,
                                                          //                                                     height: 40,
                                                          //                                                   )
                                                          //                                                 : Image.asset(
                                                          //                                                     "assets/images/avatar.png",
                                                          //                                                     width: 40,
                                                          //                                                     height: 40,
                                                          //                                                   ),
                                                          //                                             SizedBox(
                                                          //                                               width: 16,
                                                          //                                             ),
                                                          //                                             Column(
                                                          //                                               crossAxisAlignment: CrossAxisAlignment.start,
                                                          //                                               mainAxisAlignment: MainAxisAlignment.start,
                                                          //                                               children: [
                                                          //                                                 Text(
                                                          //                                                   worker.fullName.toString(),
                                                          //                                                   style: Theme.of(context).textTheme.displayLarge,
                                                          //                                                 ),
                                                          //                                                 // Text(worker['jobsNumber'].toString() + ' Job Assigned for the same day', style: Theme.of(context).textTheme.headlineLarge)
                                                          //                                               ],
                                                          //                                             )
                                                          //                                           ],
                                                          //                                         ),
                                                          //                                       ),
                                                          //                                     ),
                                                          //                                     index != controller.workers.length - 1
                                                          //                                         ? const Divider(
                                                          //                                             height: 1,
                                                          //                                             color: Color.fromARGB(59, 57, 58, 59),
                                                          //                                           )
                                                          //                                         : SizedBox(),
                                                          //                                   ],
                                                          //                                 );
                                                          //                               }).toList(),
                                                          //                             ),
                                                          //                           ),
                                                          //                         )),

                                                          //                     //  SizedBox(height: 12,),
                                                          //                     Dialog(
                                                          //                       insetPadding:
                                                          //                           EdgeInsets.all(16),
                                                          //                       backgroundColor:
                                                          //                           ConstantColors.cardColor,
                                                          //                       shape:
                                                          //                           const RoundedRectangleBorder(
                                                          //                         borderRadius: BorderRadius.all(
                                                          //                           Radius.circular(10.0),
                                                          //                         ),
                                                          //                       ),
                                                          //                       child:
                                                          //                           Padding(
                                                          //                         padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                          //                         child: InkWell(
                                                          //                           onTap: () {
                                                          //                             Get.back();
                                                          //                           },
                                                          //                           child: Center(
                                                          //                             child: Text(
                                                          //                               'Cancel',
                                                          //                               style: TextStyle(
                                                          //                                 color: ConstantColors.secondaryColor,
                                                          //                                 fontSize: 17,
                                                          //                                 fontWeight: FontWeight.w400,
                                                          //                                 fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                          //                               ),
                                                          //                             ),
                                                          //                           ),
                                                          //                         ),
                                                          //                       ),
                                                          //                     ),
                                                          //                   ],
                                                          //                 ))
                                                          //   },
                                                          // ),
                                                          // SizedBox(
                                                          //   width: 10,
                                                          // ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          12),
                                                              fixedSize: Get
                                                                          .locale!
                                                                          .countryCode ==
                                                                      'en'
                                                                  ? const Size(
                                                                      74, 36)
                                                                  : const Size(
                                                                      80, 36),
                                                              backgroundColor:
                                                                  ConstantColors
                                                                      .primaryColor,
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              children: [
                                                                SvgPicture.asset(
                                                                    callWhite),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'Call'.tr,
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: ConstantColors
                                                                          .cardColor,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily: localization ==
                                                                              "en"
                                                                          ? GoogleFonts.roboto()
                                                                              .fontFamily
                                                                          : 'DubaiFont',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            onPressed: () async =>
                                                                await FlutterPhoneDirectCaller
                                                                    .callNumber(job
                                                                        .customerPhone!
                                                                        .toString()),
                                                          ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          12),
                                                              fixedSize:
                                                                  const Size(
                                                                      111, 36),
                                                              backgroundColor:
                                                                  const Color(
                                                                      0xff00DD00),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                SvgPicture.asset(
                                                                    whatsAppWhite),
                                                                const SizedBox(
                                                                  width: 2,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                    'WhatsApp'
                                                                        .tr,
                                                                    style:
                                                                        TextStyle(
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      color: ConstantColors
                                                                          .cardColor,
                                                                      fontSize:
                                                                          13,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontFamily: localization ==
                                                                              "en"
                                                                          ? GoogleFonts.roboto()
                                                                              .fontFamily
                                                                          : 'DubaiFont',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            onPressed:
                                                                () async {
                                                              await launch(
                                                                  'whatsapp://send?phone=${job.customerWhatsappNumber}');
                                                            },
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
                                                              const Divider(
                                                                color: ConstantColors
                                                                    .borderColor,
                                                                height: 24,
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                color: const Color(
                                                                    0xffE3E4E5),
                                                                child: Row(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .center,
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                            wallet),
                                                                    const SizedBox(
                                                                      width: 8,
                                                                    ),
                                                                    Text(
                                                                      '${'AED'.tr} ${job.price}${job.paymentMethod == 'cashondelivery' ? ' (Cash on Delivery)'.tr : ' (Pay By Card)'.tr}',
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
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        job.day.toString() +
                                                                            ' ' +
                                                                            job.date!.split(' ')[0].toString(),
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .displayMedium,
                                                                      ),
                                                                      Text(
                                                                        "${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['from']} - ${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['to']}"
                                                                            .toString(),
                                                                        style: Theme.of(context)
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
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Column(
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        job.vehicle!.carBrand!.name.toString() ??
                                                                            '' +
                                                                                ' ' +
                                                                                job.vehicle!.carModel!.name.toString() ??
                                                                            '' + "\n" + job.vehicle!.year!.toString() ??
                                                                            '' + ', ' + job.vehicle!.color!.toString() ??
                                                                            '' + ' ( ' + job.vehicle!.gearType!.toString() ??
                                                                            '' + ' Gear )'.tr,
                                                                        style: Theme.of(context)
                                                                            .textTheme
                                                                            .displayMedium,
                                                                      ),
                                                                      Text(
                                                                        job.vehicle!.plateCode.toString() ??
                                                                            '' +
                                                                                ' - ' +
                                                                                job.vehicle!.plateNumber.toString() ??
                                                                            '',
                                                                        style: Theme.of(context)
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
                                                                  const SizedBox(
                                                                    width: 8,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          job.address != null
                                                                              ? job.address!.address![0].toString()
                                                                              : '',
                                                                          style: Theme.of(context)
                                                                              .textTheme
                                                                              .displayMedium,
                                                                        ),
                                                                        Text(
                                                                          '',
                                                                          style: Theme.of(context)
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
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              // Column(children:(job['services'] as List).map<Widget>((service) =>
                                                              // Container(
                                                              //   margin: EdgeInsets.only(bottom: 4),
                                                              //   child: Row(
                                                              //     children: [
                                                              //       SvgPicture.asset(checkCircle),
                                                              //       SizedBox(width: 8,),
                                                              //       Expanded(child: Text(service,style: Theme.of(context).textTheme.displayMedium,))
                                                              //     ],
                                                              //   ),
                                                              // )).toList(),),
                                                              const Divider(
                                                                color: ConstantColors
                                                                    .borderColor,
                                                                height: 24,
                                                              ),
                                                              Text(
                                                                'Additional Information '
                                                                    .tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              // Column(children:[
                                                              // Row(
                                                              //   children: [
                                                              //     SvgPicture.asset(steppers_blue),
                                                              //     SizedBox(width: 8,),
                                                              //     Expanded(child: Text('Wax, Trash bag, Tissue pack, Perfuming, Floor matscasing',style: Theme.of(context).textTheme.displayMedium,))
                                                              //   ],
                                                              // ),
                                                              // SizedBox(height: 4,),
                                                              //  Row(
                                                              //   children: [
                                                              //     SvgPicture.asset(flash_off),
                                                              //     SizedBox(width: 8,),
                                                              //     Expanded(child: Text('No power outlet required',style: Theme.of(context).textTheme.displayMedium,))
                                                              //   ],
                                                              // ),
                                                              // SizedBox(height: 4,),
                                                              //  Row(
                                                              //   children: [
                                                              //     SvgPicture.asset(schedule_blue),
                                                              //     SizedBox(width: 8,),
                                                              //     Expanded(child: Text('Duration: 1 HOUR',style: Theme.of(context).textTheme.displayMedium,))
                                                              //   ],
                                                              // ),
                                                              // ]),

                                                              const Divider(
                                                                color: ConstantColors
                                                                    .borderColor,
                                                                height: 24,
                                                              ),
                                                              Text(
                                                                'Add-ons'.tr,
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .titleSmall,
                                                              ),
                                                              const SizedBox(
                                                                height: 16,
                                                              ),
                                                              Row(
                                                                children: job
                                                                    .addOns!
                                                                    .map((addOn) =>
                                                                        SingleChildScrollView(
                                                                          scrollDirection:
                                                                              Axis.horizontal,
                                                                          child:
                                                                              Row(
                                                                            mainAxisSize:
                                                                                MainAxisSize.min,
                                                                            children: [
                                                                              ElevatedButton(
                                                                                style: ElevatedButton.styleFrom(
                                                                                  backgroundColor: ConstantColors.secondaryColor,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                  ),
                                                                                ),
                                                                                child: Padding(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                    vertical: 8,
                                                                                  ),
                                                                                  child: Text(
                                                                                    addOn.name!.toUpperCase(),
                                                                                    style: TextStyle(
                                                                                      overflow: TextOverflow.ellipsis,
                                                                                      color: ConstantColors.cardColor,
                                                                                      fontSize: 15,
                                                                                      fontWeight: FontWeight.w900,
                                                                                      fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                onPressed: () => {},
                                                                              ),
                                                                              const SizedBox(
                                                                                width: 12,
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ))
                                                                    .toList(), // Convert Iterable to List here
                                                              )
                                                            ],
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList())
                                  : controller.selectedTab.value ==
                                          'In Process'.tr
                                      ? controller.inProcessJobs.isEmpty
                                          ? Center(
                                              child: Text(
                                                'NO ORDERS FOUND'.tr,
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 14),
                                              ),
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: controller.inProcessJobs
                                                  .map((job) {
                                                var index = controller
                                                    .inProcessJobs
                                                    .indexOf(job);
                                                bool isExpanded =
                                                    controller.expandedStates[
                                                            index] ??
                                                        false;
                                                return InkWell(
                                                  onTap: () {
                                                    controller
                                                        .toggleExpansion(index);
                                                  },
                                                  child: Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            bottom: 16),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 16,
                                                        horizontal: 24),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      color: ConstantColors
                                                          .cardColor,
                                                      border: Border.all(
                                                          color: ConstantColors
                                                              .borderColor),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Row(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Expanded(
                                                              child: Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  RichText(
                                                                    text:
                                                                        TextSpan(
                                                                      text: 'Order ID: '
                                                                          .tr,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              11,
                                                                          fontWeight: FontWeight
                                                                              .w400,
                                                                          color: ConstantColors
                                                                              .primaryColor,
                                                                          fontFamily: localization == "en"
                                                                              ? GoogleFonts.roboto()
                                                                                  .fontFamily
                                                                              : 'DubaiFont',
                                                                          overflow:
                                                                              TextOverflow.ellipsis),
                                                                      children: <TextSpan>[
                                                                        TextSpan(
                                                                          text: job
                                                                              .id
                                                                              .toString(),
                                                                          style: TextStyle(
                                                                              fontSize: 11,
                                                                              fontWeight: FontWeight.w700,
                                                                              color: ConstantColors.primaryColor,
                                                                              fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                              overflow: TextOverflow.ellipsis),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    job.customerName
                                                                        .toString(),
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            isExpanded
                                                                ? const Icon(
                                                                    Icons
                                                                        .expand_less,
                                                                    color: ConstantColors
                                                                        .hintColor,
                                                                  )
                                                                : const Icon(
                                                                    Icons
                                                                        .expand_more,
                                                                    color: ConstantColors
                                                                        .hintColor,
                                                                  ),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                          height: 12,
                                                        ),
                                                        SingleChildScrollView(
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          child: Row(
                                                            // mainAxisAlignment:
                                                            // MainAxisAlignment.spaceBetween,
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            children: [
                                                              // ElevatedButton(
                                                              //   style:
                                                              //       ElevatedButton
                                                              //           .styleFrom(
                                                              //     padding: EdgeInsets
                                                              //         .symmetric(
                                                              //             vertical:
                                                              //                 8,
                                                              //             horizontal:
                                                              //                 12),
                                                              //     fixedSize:
                                                              //         Size(86, 36),
                                                              //     backgroundColor:
                                                              //         ConstantColors
                                                              //             .secondaryColor,
                                                              //     shape:
                                                              //         RoundedRectangleBorder(
                                                              //       borderRadius:
                                                              //           BorderRadius
                                                              //               .circular(
                                                              //                   8),
                                                              //     ),
                                                              //   ),
                                                              //   child: Text(
                                                              //     'Assign'
                                                              //         .toUpperCase(),
                                                              //     style: TextStyle(
                                                              //       overflow:
                                                              //           TextOverflow
                                                              //               .ellipsis,
                                                              //       color: ConstantColors
                                                              //           .cardColor,
                                                              //       fontSize: 13,
                                                              //       fontWeight:
                                                              //           FontWeight
                                                              //               .w700,
                                                              //       fontFamily: localization ==
                                                              //               "en"
                                                              //           ? GoogleFonts
                                                              //                   .roboto()
                                                              //               .fontFamily
                                                              //           : 'DubaiFont',
                                                              //     ),
                                                              //   ),
                                                              //   onPressed:
                                                              //       () async => {
                                                              //     await controller
                                                              //         .getWorkers(
                                                              //             job.date,
                                                              //             ""),
                                                              //     showDialog(
                                                              //         context:
                                                              //             context,
                                                              //         builder:
                                                              //             (_) =>
                                                              //                 Column(
                                                              //                   mainAxisAlignment:
                                                              //                       MainAxisAlignment.center,
                                                              //                   children: [
                                                              //                     Dialog(
                                                              //                         insetPadding: EdgeInsets.symmetric(horizontal: 16),
                                                              //                         backgroundColor: ConstantColors.cardColor,
                                                              //                         shape: const RoundedRectangleBorder(
                                                              //                           borderRadius: BorderRadius.all(
                                                              //                             Radius.circular(10.0),
                                                              //                           ),
                                                              //                         ),
                                                              //                         child: Container(
                                                              //                           width: double.infinity,
                                                              //                           child: SingleChildScrollView(
                                                              //                             child: Column(
                                                              //                               crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                               mainAxisAlignment: MainAxisAlignment.start,
                                                              //                               children: controller.popUpLoading.value
                                                              //                                   ? List.generate(
                                                              //                                       2,
                                                              //                                       (index) => Padding(
                                                              //                                             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                                                              //                                             child: Shimmer.fromColors(
                                                              //                                               baseColor: Colors.grey[300]!,
                                                              //                                               highlightColor: Colors.grey[100]!,
                                                              //                                               child: Container(
                                                              //                                                 decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.white),
                                                              //                                                 height: 50,
                                                              //                                                 width: double.infinity,
                                                              //                                               ),
                                                              //                                             ),
                                                              //                                           ))
                                                              //                                   : controller.workers.map((worker) {
                                                              //                                       var index = controller.workers.indexOf(worker);
                                                              //                                       return Column(
                                                              //                                         children: [
                                                              //                                           InkWell(
                                                              //                                             onTap: ()=>{

                                                              //                                             },
                                                              //                                             child: Padding(
                                                              //                                               padding: const EdgeInsets.all(16.0),
                                                              //                                               child: Row(
                                                              //                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                                                 mainAxisAlignment: MainAxisAlignment.start,
                                                              //                                                 children: [
                                                              //                                                   worker.image != null && worker.image!.isNotEmpty
                                                              //                                                       ? CachedNetworkImage(
                                                              //                                                           imageUrl: worker.image!,
                                                              //                                                           width: 40,
                                                              //                                                           height: 40,
                                                              //                                                         )
                                                              //                                                       : Image.asset(
                                                              //                                                           "assets/images/avatar.png",
                                                              //                                                           width: 40,
                                                              //                                                           height: 40,
                                                              //                                                         ),
                                                              //                                                   SizedBox(
                                                              //                                                     width: 16,
                                                              //                                                   ),
                                                              //                                                   Column(
                                                              //                                                     crossAxisAlignment: CrossAxisAlignment.start,
                                                              //                                                     mainAxisAlignment: MainAxisAlignment.start,
                                                              //                                                     children: [
                                                              //                                                       Text(
                                                              //                                                         worker.fullName.toString(),
                                                              //                                                         style: Theme.of(context).textTheme.displayLarge,
                                                              //                                                       ),
                                                              //                                                       // Text(worker['jobsNumber'].toString()+' Job Assigned for the same day',style: Theme.of(context).textTheme.headlineLarge)
                                                              //                                                     ],
                                                              //                                                   )
                                                              //                                                 ],
                                                              //                                               ),
                                                              //                                             ),
                                                              //                                           ),
                                                              //                                           index != controller.workers.length - 1
                                                              //                                               ? const Divider(
                                                              //                                                   height: 1,
                                                              //                                                   color: Color.fromARGB(59, 57, 58, 59),
                                                              //                                                 )
                                                              //                                               : SizedBox(),
                                                              //                                         ],
                                                              //                                       );
                                                              //                                     }).toList(),
                                                              //                             ),
                                                              //                           ),
                                                              //                         )),

                                                              //                     //  SizedBox(height: 12,),
                                                              //                     Dialog(
                                                              //                       insetPadding: EdgeInsets.all(16),
                                                              //                       backgroundColor: ConstantColors.cardColor,
                                                              //                       shape: const RoundedRectangleBorder(
                                                              //                         borderRadius: BorderRadius.all(
                                                              //                           Radius.circular(10.0),
                                                              //                         ),
                                                              //                       ),
                                                              //                       child: Padding(
                                                              //                         padding: const EdgeInsets.symmetric(vertical: 16.0),
                                                              //                         child: InkWell(
                                                              //                           onTap: () {
                                                              //                             Get.back();
                                                              //                           },
                                                              //                           child: Center(
                                                              //                             child: Text(
                                                              //                               'Cancel',
                                                              //                               style: TextStyle(
                                                              //                                 color: ConstantColors.secondaryColor,
                                                              //                                 fontSize: 17,
                                                              //                                 fontWeight: FontWeight.w400,
                                                              //                                 fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                              //                               ),
                                                              //                             ),
                                                              //                           ),
                                                              //                         ),
                                                              //                       ),
                                                              //                     ),
                                                              //                   ],
                                                              //                 ))
                                                              //   },
                                                              // ),
                                                              // SizedBox(
                                                              //   width: 10,
                                                              // ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          12),
                                                                  fixedSize: Get
                                                                              .locale!
                                                                              .countryCode ==
                                                                          'en'
                                                                      ? const Size(
                                                                          74,
                                                                          36)
                                                                      : const Size(
                                                                          80,
                                                                          36),
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
                                                                child: Row(
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                            callWhite),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'Call'
                                                                            .tr,
                                                                        style:
                                                                            TextStyle(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          color:
                                                                              ConstantColors.cardColor,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontFamily: localization == "en"
                                                                              ? GoogleFonts.roboto().fontFamily
                                                                              : 'DubaiFont',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                onPressed: () async =>
                                                                    await FlutterPhoneDirectCaller.callNumber(job
                                                                        .customerPhone!
                                                                        .toString()),
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          8,
                                                                      horizontal:
                                                                          12),
                                                                  fixedSize:
                                                                      const Size(
                                                                          111,
                                                                          36),
                                                                  backgroundColor:
                                                                      const Color(
                                                                          0xff00DD00),
                                                                  shape:
                                                                      RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(8),
                                                                  ),
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                  children: [
                                                                    SvgPicture
                                                                        .asset(
                                                                            whatsAppWhite),
                                                                    const SizedBox(
                                                                      width: 2,
                                                                    ),
                                                                    Expanded(
                                                                      child:
                                                                          Text(
                                                                        'WhatsApp'
                                                                            .tr,
                                                                        style:
                                                                            TextStyle(
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                          color:
                                                                              ConstantColors.cardColor,
                                                                          fontSize:
                                                                              13,
                                                                          fontWeight:
                                                                              FontWeight.w700,
                                                                          fontFamily: localization == "en"
                                                                              ? GoogleFonts.roboto().fontFamily
                                                                              : 'DubaiFont',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                onPressed:
                                                                    () async {
                                                                  await launch(
                                                                      'whatsapp://send?phone=${job.customerWhatsappNumber}');
                                                                },
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
                                                                  const Divider(
                                                                    color: ConstantColors
                                                                        .borderColor,
                                                                    height: 24,
                                                                  ),
                                                                  Container(
                                                                    padding: const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                    color: const Color(
                                                                        0xffE3E4E5),
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
                                                                        const SizedBox(
                                                                          width:
                                                                              8,
                                                                        ),
                                                                        Text(
                                                                          '${'AED'.tr} ' +
                                                                              job.price.toString() +
                                                                              ' (' +
                                                                              ''.toString() +
                                                                              ')',
                                                                          style: Theme.of(context)
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
                                                                      SvgPicture
                                                                          .asset(
                                                                              calendar_clock_blue),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            job.day.toString() +
                                                                                ' ' +
                                                                                job.date!.split(' ')[0].toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.displayMedium,
                                                                          ),
                                                                          Text(
                                                                            "${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['from']} - ${controller.slots.firstWhere((slot) => slot['id'] == job.slotId)['to']}".toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headlineSmall,
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
                                                                      SvgPicture
                                                                          .asset(
                                                                              carSelected),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            job.vehicle != null
                                                                                ? job.vehicle!.carBrand!.name.toString() + ' ' + job.vehicle!.carModel!.name.toString() + "\n" + job.vehicle!.year!.toString() + ', ' + job.vehicle!.color!.toString() + ' ( ' + job.vehicle!.gearType!.toString() + ' Gear )'.tr
                                                                                : '',
                                                                            style:
                                                                                Theme.of(context).textTheme.displayMedium,
                                                                          ),
                                                                          Text(
                                                                            job.vehicle!.plateCode.toString() +
                                                                                ' - ' +
                                                                                job.vehicle!.plateNumber.toString(),
                                                                            style:
                                                                                Theme.of(context).textTheme.headlineSmall,
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
                                                                      SvgPicture
                                                                          .asset(
                                                                              location_on_blue),
                                                                      const SizedBox(
                                                                        width:
                                                                            8,
                                                                      ),
                                                                      Expanded(
                                                                        child:
                                                                            Column(
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.start,
                                                                          children: [
                                                                            Text(
                                                                              job.address!.address![0].toString(),
                                                                              style: Theme.of(context).textTheme.displayMedium,
                                                                            ),
                                                                            Text(
                                                                              '',
                                                                              style: Theme.of(context).textTheme.headlineSmall,
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SvgPicture
                                                                          .asset(
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
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 16,
                                                                  ),
                                                                  // Column(children:(job['services'] as List).map<Widget>((service) =>
                                                                  // Container(
                                                                  //   margin: EdgeInsets.only(bottom: 4),
                                                                  //   child: Row(
                                                                  //     children: [
                                                                  //       SvgPicture.asset(checkCircle),
                                                                  //       SizedBox(width: 8,),
                                                                  //       Expanded(child: Text(service,style: Theme.of(context).textTheme.displayMedium,))
                                                                  //     ],
                                                                  //   ),
                                                                  // )).toList(),),
                                                                  const Divider(
                                                                    color: ConstantColors
                                                                        .borderColor,
                                                                    height: 24,
                                                                  ),
                                                                  Text(
                                                                    'Additional Information '
                                                                        .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 16,
                                                                  ),
                                                                  // Column(children:[
                                                                  // Row(
                                                                  //   children: [
                                                                  //     SvgPicture.asset(steppers_blue),
                                                                  //     SizedBox(width: 8,),
                                                                  //     Expanded(child: Text('Wax, Trash bag, Tissue pack, Perfuming, Floor matscasing',style: Theme.of(context).textTheme.displayMedium,))
                                                                  //   ],
                                                                  // ),
                                                                  // SizedBox(height: 4,),
                                                                  //  Row(
                                                                  //   children: [
                                                                  //     SvgPicture.asset(flash_off),
                                                                  //     SizedBox(width: 8,),
                                                                  //     Expanded(child: Text('No power outlet required',style: Theme.of(context).textTheme.displayMedium,))
                                                                  //   ],
                                                                  // ),
                                                                  // SizedBox(height: 4,),
                                                                  //  Row(
                                                                  //   children: [
                                                                  //     SvgPicture.asset(schedule_blue),
                                                                  //     SizedBox(width: 8,),
                                                                  //     Expanded(child: Text('Duration: 1 HOUR',style: Theme.of(context).textTheme.displayMedium,))
                                                                  //   ],
                                                                  // ),
                                                                  // ]),

                                                                  const Divider(
                                                                    color: ConstantColors
                                                                        .borderColor,
                                                                    height: 24,
                                                                  ),
                                                                  Text(
                                                                    'Add-ons'
                                                                        .tr,
                                                                    style: Theme.of(
                                                                            context)
                                                                        .textTheme
                                                                        .titleSmall,
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 16,
                                                                  ),
                                                                  Row(
                                                                    children: job
                                                                        .addOns!
                                                                        .map((addOn) =>
                                                                            SingleChildScrollView(
                                                                              scrollDirection: Axis.horizontal,
                                                                              child: Row(
                                                                                mainAxisSize: MainAxisSize.min,
                                                                                children: [
                                                                                  ElevatedButton(
                                                                                    style: ElevatedButton.styleFrom(
                                                                                      backgroundColor: ConstantColors.secondaryColor,
                                                                                      shape: RoundedRectangleBorder(
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                      ),
                                                                                    ),
                                                                                    child: Padding(
                                                                                      padding: const EdgeInsets.symmetric(
                                                                                        vertical: 8,
                                                                                      ),
                                                                                      child: Text(
                                                                                        addOn.name!.toUpperCase(),
                                                                                        style: TextStyle(
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          color: ConstantColors.cardColor,
                                                                                          fontSize: 15,
                                                                                          fontWeight: FontWeight.w900,
                                                                                          fontFamily: localization == "en" ? GoogleFonts.roboto().fontFamily : 'DubaiFont',
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                    onPressed: () => {},
                                                                                  ),
                                                                                  const SizedBox(
                                                                                    width: 12,
                                                                                  )
                                                                                ],
                                                                              ),
                                                                            ))
                                                                        .toList(), // Convert Iterable to List here
                                                                  )
                                                                ],
                                                              )
                                                            : const SizedBox()
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              }).toList())
                                      : const SizedBox()
                        ],
                      ),
                    )));
      },
    );
  }

  Widget UserListDialog() {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: controller.workers.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: CircleAvatar(
                      // backgroundImage: NetworkImage(controller.workers[index].imageUrl),
                      child: controller.workers[index].image != null &&
                              controller.workers[index].image!.isNotEmpty
                          ? CachedNetworkImage(
                              imageUrl: controller.workers[index].image!,
                              width: 40,
                              height: 40,
                            )
                          : Image.asset(
                              "assets/images/avatar.png",
                              width: 40,
                              height: 40,
                            ),
                    ),
                    title: Text(
                      controller.workers[index].fullName.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text(controller.workers[index]['jobNumber'].toString()),
                  );
                },
              ),
            ),
            // Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  'Cancel'.tr,
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
