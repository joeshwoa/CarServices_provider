import 'package:autoflex/controllers/Company_data/services/subcategory_controller.dart';
import 'package:autoflex/controllers/Company_data/services/services_controller.dart';
import 'package:autoflex/views/Company_data/services/subcategory_details.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class SubCategoriesScreen extends StatelessWidget {
  final String title;
  SubCategoriesScreen({super.key, required this.title});
  final SubCategoryController subcategorycontroller =
      Get.put(SubCategoryController());
  /* final ServicesController servicesController = Get.find<ServicesController>(); */
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
              child: Text(title.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge),
            ),
          ),
          body: subcategorycontroller.loading.value
              ? SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: List.generate(
                          10,
                          (index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 5),
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
                    ),
                  ),
                )
              : subcategorycontroller.subCategories.isEmpty
                  ? const Center(
                      child: Text(
                        'NO SUB-CATEGORIES FOUND',
                        style: TextStyle(color: Colors.grey, fontSize: 14),
                      ),
                    )
                  : SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(children: [
                            const SizedBox(
                              height: 32,
                            ),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: subcategorycontroller.subCategories
                                    .asMap()
                                    .entries
                                    .map((entry) {
                                  int index = entry.key;
                                  var item = entry.value;

                                  return Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: ConstantColors.cardColor,
                                          border: Border.all(
                                              color:
                                                  ConstantColors.borderColor),
                                          borderRadius:
                                              BorderRadius.circular(7),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  width: 20,
                                                  height: 20,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      color: subcategorycontroller
                                                              .subSelected[
                                                                  index]
                                                                  ['selected']
                                                              .value
                                                          ? ConstantColors
                                                              .secondaryColor
                                                          : const Color(
                                                              0xffC8C9CC),
                                                    ),
                                                  ),
                                                  child: Checkbox(
                                                    side: const BorderSide(
                                                        color:
                                                            Colors.transparent),
                                                    focusColor: ConstantColors
                                                        .secondaryColor,
                                                    activeColor: ConstantColors
                                                        .backgroundColor,
                                                    checkColor: ConstantColors
                                                        .secondaryColor,
                                                    value: subcategorycontroller
                                                        .subSelected[index]
                                                            ['selected']
                                                        .value,
                                                    onChanged: (value) {
                                                      if (subcategorycontroller
                                                          .subSelected[index]
                                                              ['selected']
                                                          .value) {
                                                        //THIS ID IS THE COMPANY'S PRODUCT ID
                                                        subcategorycontroller.editService(
                                                            subcategorycontroller
                                                                    .subSelected[
                                                                index]['id']);
                                                      }
                                                      Get.to(
                                                        () =>
                                                            SubCategoryDetailsScreen(
                                                          title:
                                                              item.name ?? '',
                                                          subId: item.id!,
                                                          companySubId:
                                                              subcategorycontroller
                                                                      .subSelected[
                                                                  index]['id'],
                                                        ),
                                                        arguments: {
                                                          'categoryId':
                                                              Get.arguments[
                                                                  'categoryId'],
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 12,
                                                ),
                                                Text(
                                                  item.name ?? '',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                    ],
                                  );
                                }).toList())
                          ])),
                    )),
    );
  }
}
