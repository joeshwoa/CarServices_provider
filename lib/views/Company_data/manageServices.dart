import 'package:autoflex/views/Company_data/services/carWashing&detailing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../shared/components/serviceButton.dart';
import '../../shared/styles/colors.dart';
import '../../shared/styles/icons_assets.dart';

List<Widget> services = [
  createButton(label: 'CARWASH & DETAILING'.tr,prefixIcon:  carWash,suffixIcon:  navigateNext,screen:  (){Get.to(() => CarWashingAndDetailingScreen());}),
  createButton(label: 'TYRES & WHEELS'.tr,prefixIcon:  wheels,suffixIcon:  navigateNext,screen:  (){}),
  createButton(label: 'ENGINE WORKS'.tr,prefixIcon:  engineWorks,suffixIcon:  navigateNext,screen: (){}),
  createButton(label: 'AC SERVICES'.tr,prefixIcon:  AC,suffixIcon:  navigateNext,screen: (){}),
  createButton(label: 'BATTERY CHARGE'.tr,prefixIcon:  battery,suffixIcon:  navigateNext,screen: (){}),
  createButton(label: 'OIL CHANGE'.tr,prefixIcon:  oil,suffixIcon:  navigateNext,screen: (){}),
  createButton(label: 'TOWING & RECOVERY SERVICES'.tr,prefixIcon:  towing,suffixIcon:  navigateNext,screen:  (){}),
  createButton(label: 'SANITIZATION SERVICES'.tr,prefixIcon:  sanitization,suffixIcon:  navigateNext,screen: (){}),
  createButton(label: 'AUTO ELECTRICIAN SERVICES'.tr,prefixIcon:  electric,suffixIcon:  navigateNext,screen: (){}),
];

class ManageServicesScreen extends StatelessWidget {
  ManageServicesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return 
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
                child: Text('Manage Services'.tr.toUpperCase(),
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
                             Column(children:services.map((service) => service).toList(),
                             )
                          ]))));}}