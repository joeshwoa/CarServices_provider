
import 'package:autoflex/services/terms_and_conditions_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class TermsAndConditionsController extends GetxController {

  var content=''.obs;
  var loading=false.obs;

  @override
  void onInit() async {
    super.onInit();
    await getTermsRequest();
  }
Future<void> getTermsRequest() async {
  try {
    loading.value = true;
    String? getTermsRequest = await TermsAndConditionsService.getTermsAndConditions();
    content.value=getTermsRequest??'';
    loading.value = false;


  } catch (e) {
    loading.value = false;
    if (kDebugMode) {
      print(e);
    }
  }
}
}
