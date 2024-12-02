import 'package:autoflex/models/company%20workers/WorkerDetails.dart';
import 'package:autoflex/models/login.dart' as login;
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/faqs_service.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/services/worker/workerMenu_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get.dart';

class WorkerMenuController extends GetxController {
  var loading = false.obs;
  var pref = Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  Rx<WorkerDetails> workerDetails = WorkerDetails(data: Data()).obs;

  @override
  void onInit() async {
    super.onInit();
    await getWorkerDetails();
  }

  Future<void> getWorkerDetails() async {
    try {
      loading.value = true;
      WorkerDetails? getWorkerDetailsRequest =
          await WorkerMenuServices.getWorkerDetails();
      if (getWorkerDetailsRequest != null) {
        workerDetails.value = getWorkerDetailsRequest;
      }

      loading.value = false;
    } catch (e) {
      loading.value = false;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> updateWorkerDetails(WorkerDetails newDetails) async {
    loading.value = true;
    List<dynamic> updateWorkerDetailsRequest =
        await WorkerMenuServices.updateWorkerDetails(
            newDetails, workerDetails.value);

    toast(message: updateWorkerDetailsRequest[1]);
    if (updateWorkerDetailsRequest[0]) {
      workerDetails.value = updateWorkerDetailsRequest[2];
    }

    loading.value = false;
  }

  Future<String?> logoutRequest() async {
    loading.value = true;
    var logoutRequest = await AuthService.signoutWorker();
    dynamic isLoggedIn = false;
    login.Login userData = login.Login();
    dynamic token = "";
    dynamic userType = "";

    pref.setBoolValue("isLoggedIn", false);
    pref.setValue("token", "");
    pref.setValue("userType", "");
    pref.setValue("userData", login.Login());

    pref.userToken.value = token;
    pref.isLoggedIn.value = isLoggedIn;
    pref.userData.value = userData;

    loading.value = false;
    if (logoutRequest['message'] != null) {
      toast(message: logoutRequest['message']);
    }
  }
}
