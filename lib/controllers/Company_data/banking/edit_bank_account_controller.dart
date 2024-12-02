import 'dart:developer';

import 'package:autoflex/controllers/Company_data/banking/banking_controller.dart';
import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/services/company/banking_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditBankingController extends GetxController {
  final bankAccountFormKey = GlobalKey<FormState>();
  final BankingController controller = Get.find<BankingController>();
  var loading = false.obs;
  var populated = false.obs;
  var account = Account().obs;
  var bankNameController = TextEditingController().obs;
  var accountTitleController = TextEditingController().obs;
  var accountNumberController = TextEditingController().obs;
  var ibanController = TextEditingController().obs;

  @override
  void onInit() {
    super.onInit();
    inspect(Get.arguments);
    var type = Get.arguments['type'] ?? 'add';
    if (type == 'edit' && !populated.value) {
      editAccount();
    }
  }

  editAccount() async {
    populated.value = true;
    loading.value = true;
    account.value =
        (await BankingServices.showAccount(Get.arguments['accountId']))!;
    inspect(account.value);
    bankNameController.value.text = account.value.data!.bankName ?? "";
    accountTitleController.value.text = account.value.data!.accountTitle ?? "";
    ibanController.value.text = account.value.data!.iban ?? "";
    accountNumberController.value.text =
        account.value.data!.accountNumber ?? "";
    loading.value = false;
  }

  checkValidation() {
    final isValid = bankAccountFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  createAccount() async {
    if (checkValidation()) {
      loading.value = true;
      var createAccountRequest = await BankingServices.addAccount(
          bankName: bankNameController.value.text,
          accountName: accountTitleController.value.text,
          accountNumber: accountNumberController.value.text,
          iban: ibanController.value.text);
      inspect(createAccountRequest);
      toast(message: 'Bank Account Added Successfully'.tr);
      Get.back();
      await controller.getAccounts();
      loading.value = false;
    } else {
      toast(message: 'Something Went Wrong'.tr);
      loading.value = false;
    }
  }

  updateAccount() async {
    if (checkValidation()) {
      loading.value = true;
      var updateAccountRequest = await BankingServices.updateAccount(
          accountId: Get.arguments['accountId'],
          bankName: bankNameController.value.text,
          accountName: accountTitleController.value.text,
          accountNumber: accountNumberController.value.text,
          iban: ibanController.value.text);
      if (updateAccountRequest != null) {
        toast(message: "Account Updated Successfully");
        Get.back();
        await controller.getAccounts();
        loading.value = false;
      } else {
        toast(message: "Something Went Wrong");
        loading.value = false;
      }
    }
  }
}
