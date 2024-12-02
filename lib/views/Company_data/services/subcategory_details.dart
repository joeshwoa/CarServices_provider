import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/subcategory_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/Company_data/services/subcategory_controller.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class SubCategoryDetailsScreen extends StatelessWidget {
  final String title;
  final int subId;
  final int? companySubId;
  SubCategoryDetailsScreen(
      {super.key, required this.title, required this.subId, this.companySubId});
  final SubCategoryController controller = Get.find<SubCategoryController>();
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
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
                      controller.resetFields();
                      Get.back();
                    },
                  ),
                ),
                centerTitle: true,
                title: Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: Text(title.toUpperCase(),
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
                        subCategory(
                            id: subId,
                            title: title,
                            context: context,
                            type: 'FoamWash',
                            serviceRates: controller.servisesRates.value),
                        const SizedBox(
                          height: 40,
                        ),
                        FormSubmitButton(
                            onPressed: () async {
                              if (controller.aboutToDisable.value &&
                                  companySubId != null) {
                                await controller.disableService(companySubId);
                                await companyDetailsController
                                    .getCompanyServices();
                              } else {
                                if (companySubId == null) {
                                  await controller.addService(subId);
                                  await companyDetailsController
                                      .getCompanyServices();
                                } else {
                                  await controller.updateService(
                                      subId: subId, companySubId: companySubId);
                                  await companyDetailsController
                                      .getCompanyServices();
                                }
                              }
                            },
                            label: 'Save'),
                        const SizedBox(
                          height: 54,
                        ),
                      ])))),
          controller.loading.value ? const LoadingWidget() : const Row()
        ],
      ),
    );
  }
}
