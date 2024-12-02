import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/otp.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BankAccountController extends GetxController {
  final bankAccountFormKey = GlobalKey<FormState>();

  var loading = false.obs;
  var errorMessage = "".obs;
  TextEditingController bankController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController accountNumberController = TextEditingController();
  TextEditingController ibanController = TextEditingController();

  var populated = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  editAccount() {
    Map<String, dynamic> account = {
      'bank': 'ABK',
      'name': 'dream wash LLC',
      'iban': 'AE215686456845681325123',
      'account_number': '456845681325123',
    };

    nameController.text = account['name'];
    bankController.text = account['bank'];
    ibanController.text = account['iban'];
    accountNumberController.text = account['account_number'];

    populated.value = true;
  }

  checkValidation() {
    final isValid = bankAccountFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  addAccount() {
    if (checkValidation()) {
      Get.to(() => ManageWorkersScreen());
      try {} catch (e) {
        print(e);
      }
    }
  }
}
