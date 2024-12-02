import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../controllers/Company_data/services/carWashing-controller.dart';
import '../../../shared/components/carWashItem.dart';
import '../../../shared/styles/colors.dart';
import '../../../shared/styles/icons_assets.dart';

class CarWashingItemDetailsScreen extends StatelessWidget {
  CarWashingItemDetailsScreen({super.key});
  final CarWashingController controller = Get.find();
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
                            carWashItem(title: 'Foam Wash',context:context,type:'FoamWash',serviceRates: controller.servisesRates ),
                            const SizedBox(height: 40,),
                            FormSubmitButton(onPressed: (){
                              Get.back();
                            },label: 'Save'),
                            const SizedBox(height: 54,),
                            ]))));}}