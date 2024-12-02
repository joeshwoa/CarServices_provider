import 'package:autoflex/controllers/terms_and_conditions_controller.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final TermsAndConditionsController termsAndConditionsController = Get.put(TermsAndConditionsController());
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
            child: Text('TERMS & CONDITIONS'.tr,
                style: Theme.of(context).textTheme.titleLarge),
          ),
        ),
        body: termsAndConditionsController.loading.value ? Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 30,
                    width: 100,
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
                padding: EdgeInsetsDirectional.only(start: 16),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: MediaQuery.of(context).size.height*0.18,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                            Radius.circular(10))),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8),
                child: Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    height: 30,
                    width: 100,
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
              Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 16),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                              Radius.circular(10))),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) : SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Text(
              termsAndConditionsController.content.value,
              style: TextStyle(
                  color: Color(0xFF292B33),
                  fontSize: 11,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                  overflow: TextOverflow.visible),
            ),
          ),
        ),
           ),
     );
  }
}
