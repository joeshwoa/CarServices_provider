import 'dart:developer';

import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/models/bank/bank_accounts.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/services/company/banking_services.dart';
import 'package:autoflex/services/company/company_workers_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CompanyWorkersDetailsController extends GetxController {
  var loading = false.obs;
  var errorMessage = "".obs;
  var workers = <CompanyWorker>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getCompanyWorkers();
  }

  getCompanyWorkers() async {
    loading.value = true;
    var getCompanyWorkersRequest =
        await CompanyWorkersServices.getCompanyWorkers();
    if (getCompanyWorkersRequest != null) {
      workers.value = getCompanyWorkersRequest!.data!;
    } else {
      toast(message: 'Could not Find Service Areas'.tr);
    }
    loading.value = false;
  }

   deleteWorker(id, index) async {
    loading.value = true;
    var deleteWorkersRequest = await CompanyWorkersServices.deleteWorker(id,);
    if (deleteWorkersRequest != null) {
      toast(message: deleteWorkersRequest['message']);
      workers.removeAt(index);

    } else {
      toast(message: "Could not Delete Account".tr);
      inspect(deleteWorkersRequest);
    }
    loading.value = false;
  }
}
