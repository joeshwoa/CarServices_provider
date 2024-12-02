import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/shared/components/worker_card.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/manage%20workers/add_worker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class ManageWorkersScreen extends StatelessWidget {
  ManageWorkersScreen({super.key});
  final CompanyWorkersDetailsController controller =
      Get.put(CompanyWorkersDetailsController());
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          backgroundColor: ConstantColors.backgroundColor,
          title: Text(
            'Manage workers'.tr.toUpperCase(),
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
                    children: List.generate(
                        6,
                        (index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  decoration: const BoxDecoration(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      color: Colors.white),
                                  height: 150,
                                  width: double.infinity,
                                ),
                              ),
                            )),
                  )
                : Column(
                    children: [
                      ...controller.workers.map((worker) => WorkerCard(
                            worker: worker,
                            index: controller.workers.indexOf(worker),
                          )),
                      FractionallySizedBox(
                          widthFactor: 1,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  8), // Same as the button's shape
                            ),
                            child: TextButton.icon(
                              style: ButtonStyle(
                                padding: const MaterialStatePropertyAll(
                                    EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 12)),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        8), // Same as the container's border radius
                                  ),
                                ),
                                backgroundColor: MaterialStateProperty.all(
                                  ConstantColors
                                      .primaryColor, // Button background color
                                ),
                                alignment: Get.locale!.languageCode == 'en'
                                    ? Alignment.centerLeft
                                    : Alignment
                                        .centerRight, // Align icon and text to the left
                              ),
                              onPressed: () {
                                Get.to(() => AddWorkerScreen(),
                                    arguments: {'type': 'add'});
                              },
                              icon: SvgPicture.asset(
                                addWhite, // Icon color
                              ),
                              label: Text(
                                'Add New Worker'.tr,
                                style: TextStyle(
                                  color: ConstantColors.cardColor, // Text color
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                  letterSpacing: -0.17,
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
