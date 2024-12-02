
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/components/success.dart';

class SucessScreen extends StatelessWidget {
  SucessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return
       Scaffold(
          backgroundColor: ConstantColors.backgroundColor,
          body: SingleChildScrollView(child: sucess(type: Get.arguments['type'])),
       );}}