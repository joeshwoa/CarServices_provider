import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/controllers/Company_data/services/services_controller.dart';
import 'package:autoflex/views/Company_data/services/subCategoriesScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/components/serviceButton.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class ManageServicesScreen extends StatelessWidget {
  ManageServicesScreen({super.key});
  final ServicesController controller = Get.put(ServicesController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          backgroundColor: ConstantColors.backgroundColor,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: ConstantColors.backgroundColor,
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
            centerTitle: true,
            title: Padding(
              padding: const EdgeInsetsDirectional.only(top: 16.0),
              child: Text('Manage Services'.tr.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          body: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(children: [
                    const SizedBox(
                      height: 32,
                    ),
                    controller.loading.value
                        ? Column(
                            children: List.generate(
                                10,
                                (index) => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      child: Shimmer.fromColors(
                                        baseColor: Colors.grey[300]!,
                                        highlightColor: Colors.grey[100]!,
                                        child: Container(
                                          decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Colors.white),
                                          height: 50,
                                          width: double.infinity,
                                        ),
                                      ),
                                    )),
                          )
                        : Column(
                            children: controller.services
                                .map((service) => service)
                                .toList(),
                          )
                  ])))),
    );
  }
}
