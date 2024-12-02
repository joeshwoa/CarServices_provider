import 'dart:developer';

import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/models/bank/bank_accounts.dart';
import 'package:autoflex/services/company/banking_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankingController extends GetxController {
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
  var loading = false.obs;
  var errorMessage = "".obs;
  var accounts = <Datum>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getAccounts();
  }

  getAccounts() async {
    loading.value = true;
    var getAccountsRequest = await BankingServices.getAccounts();
    accounts.value = getAccountsRequest!.data!;
    loading.value = false;
  }

  deleteAccount(id) async {
    loading.value = true;
    var deleteAccountRequest = await BankingServices.deleteAccount(id);
    if (deleteAccountRequest != null) {
      toast(message: deleteAccountRequest['message']);
      await getAccounts();
      await companyDetailsController.getBankAccounts();
    } else {
      toast(message: "Could not Delete Account".tr);
      inspect(deleteAccountRequest);
    }
    loading.value = false;
  }
}
