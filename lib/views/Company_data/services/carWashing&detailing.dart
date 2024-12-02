import 'package:autoflex/controllers/Company_data/services/carWashing-controller.dart';
import 'package:autoflex/views/Company_data/services/carWashingItemDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../shared/components/carWashItem.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class CarWashingAndDetailingScreen extends StatelessWidget {
  CarWashingAndDetailingScreen({super.key});
  final CarWashingController controller = Get.put(CarWashingController());
  @override
  Widget build(BuildContext context) {
    return 
   
          Obx(()=>
            Scaffold(
                backgroundColor: ConstantColors.backgroundColor,
                appBar: AppBar(
                  
                  elevation: 0.0,
                  backgroundColor: ConstantColors.backgroundColor,
                  leading:   Padding(
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
                    child: Text('Car Wash & Detailing'.toUpperCase(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleLarge),
                  ),
                                             ),
                body: SingleChildScrollView(
                    child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child:
                          Column(children: [
                                const SizedBox(
                                height: 32,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: controller.carWashingItems.map((item)=>
                                Column(
                                  children: [
                                    Container(
                                                                  
                                                                  padding: const EdgeInsets.all(16),
                                                                  decoration: BoxDecoration(
                                     color: ConstantColors.cardColor,
                                              border: Border.all(color: ConstantColors.borderColor),
                                              borderRadius: BorderRadius.circular(7)),
                                                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                              Row(
                                                children: [
                                                  Container(
                                                                  width: 20,
                                                                  height: 20,
                                                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: controller.itemSelected.value
                                              ? ConstantColors.secondaryColor
                                              : const Color(0xffC8C9CC))),
                                                                  child: Checkbox(
                                      side: BorderSide(color: Colors.transparent),
                                      focusColor: ConstantColors.secondaryColor,
                                      activeColor: ConstantColors.backgroundColor,
                                      checkColor: ConstantColors.secondaryColor,
                                      value: controller.itemSelected.value,
                                      onChanged: (value) {
                                        controller.itemSelected.value = value!;
                                        Get.to(()=>CarWashingItemDetailsScreen());
                                      }),
                                                  ),
                                                  const SizedBox(
                                                                  width: 12,
                                                  ),
                                                  Text(
                                                                  item,
                                                                  style: Theme.of(context).textTheme.displayMedium,
                                                  ),
                                                ],
                                              ),
                                    ])),
                                  SizedBox(height: 12,)
                                  ],
                                )).toList())])))),
          );}}