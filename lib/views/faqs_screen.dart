import 'package:autoflex/controllers/faqs_controller.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/select_menu_item.dart';
import 'package:autoflex/shared/components/text-field.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/shared/validations.dart';
import 'package:autoflex/views/talk_to_us_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FAQsController faqsController = Get.put(FAQsController());
    return Obx(
      () => Scaffold(
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
            child: Text('FAQs'.tr, style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        body: faqsController.loading.value ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 70,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
            ],
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children:
                  faqsController.questions.asMap().entries.map((entry) {
                    int index = entry.key;
                    Map<String, dynamic> question = entry.value;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: ConstantColors.borderColor),
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: GetBuilder<FAQsController>(
                        builder: (_) {
                          final isExpanded =
                              faqsController.expandedIndex.value == index;
                          return ExpansionTile(
                            key: Key(index.toString()), // Add a unique key
                            controller: faqsController.controllers[index],
                            dense: true,
                            childrenPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            tilePadding:
                            const EdgeInsets.symmetric(horizontal: 10),
                            iconColor: ConstantColors.secondaryColor,
                            collapsedIconColor: ConstantColors.hintColor,
                            expandedCrossAxisAlignment:
                            CrossAxisAlignment.start,
                            title: Text(
                              question['question']!,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                color: isExpanded
                                    ? ConstantColors.secondaryColor
                                    : ConstantColors.bodyColor2,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                            children: [
                              Text(
                                question['answer']!,
                                style: const TextStyle(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ],
                            onExpansionChanged: (bool expanded) {
                              faqsController.changeQuestion(index);
                            },
                          );
                        },
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Get.to(() => TalkToUsScreen());
                  },
                  child: Container(
                    width: double.infinity,
                    height: 81,
                    padding: const EdgeInsets.all(20),
                    decoration: ShapeDecoration(
                      color: const Color(0xFF002F6C),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'Didn’t find the answer you are looking for?\n'
                                        .tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                  letterSpacing: -0.13,
                                ),
                              ),
                              TextSpan(
                                text: 'Contact our team'.tr,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.w500,
                                  height: 0,
                                  letterSpacing: -0.17,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
