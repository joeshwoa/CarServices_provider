import 'package:autoflex/models/workerHome/woker_orders.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/views/Home/provider/menu.dart';
import 'package:autoflex/views/Home/worker/workerMenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../controllers/Home/worker/workerHome-controller.dart';
import '../../../main.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class PastJobsScreen extends StatefulWidget {
  PastJobsScreen({super.key});

  @override
  State<PastJobsScreen> createState() => _PastJobsScreenState();
}

class _PastJobsScreenState extends State<PastJobsScreen> {
  final WorkerHomeController controller = Get.find<WorkerHomeController>();

  @override
  void initState() {
    controller.getOrders(pastJobs: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Obx(
        () {
          return Stack(
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
                        Get.to(() => WorkerMenuScreen());
                      },
                    ),
                    title: SvgPicture.asset(logo),
                    actions: [
                      IconButton(
                        icon: SvgPicture.asset(notificationsUnread),
                        onPressed: () {
                          // Get.to(() => CartScreen());
                        },
                      )
                    ],
                  ),
                  body: SingleChildScrollView(
                      child: Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text('Past Jobs'.tr,style: Theme.of(context).textTheme.titleSmall,),
                                SizedBox(height: 16,),
                                Column(   children: controller.getWorkerOrders.value.data!
                                  .map((job) => Container(
                                    margin: EdgeInsets.only(bottom: 4),
                                    padding: EdgeInsets.symmetric(horizontal: 24,vertical: 16),
                                    decoration: BoxDecoration(
                                      color: ConstantColors.cardColor,
                                      border: Border.all(color: ConstantColors.borderColor),
                                      borderRadius: BorderRadius.circular(8)
                                    ),
                                    child: Column(children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(job.status!,style: TextStyle(color:job.status=='Canceled'||job.status=='Incomplete'?ConstantColors.errorColor:Color(0xff00DD00),
                                          fontSize: 11,
                                           fontFamily: localization ==
                                                                            "en"
                                                                        ? GoogleFonts.roboto()
                                                                            .fontFamily
                                                                        : 'DubaiFont',
                                                                        fontWeight: FontWeight.w400  ),),
                                                                        Text(DateFormat('dd MMM yyyy').format(job.date!).toUpperCase(),style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,)
                                        ],
                                      ),
                                    Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                                  text: job.id
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

                                                                        Text((job.address??Address(city: '')).city.toString(),style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium,)
                                        ],
                                      ),
                                       Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text((job.product??Product(description: [])).description.toString().replaceAll('[', '').replaceAll(']', ''),style: Theme.of(context).textTheme.headlineSmall,),
                                                                        Text(job.price!,style: Theme.of(context)
                                                          .textTheme
                                                          .headlineSmall,)
                                        ],
                                      ),


                                    ],),

                                  )).toList())

                              ],),
                      ))),
              controller.loading.value ? const LoadingWidget() : Row()
            ],
          );
        }
      );}}