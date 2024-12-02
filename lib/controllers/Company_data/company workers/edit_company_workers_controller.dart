import 'dart:developer';
import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/controllers/Company_data/services/services_controller.dart';
import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/services/company/banking_services.dart';
import 'package:autoflex/services/company/company_workers_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/products/catalogue.dart';

class EditCompanyWorkersController extends GetxController {
  EditCompanyWorkersController({required this.workerIndex});
  final int workerIndex;
  final companyWorkerFormKey = GlobalKey<FormState>();
  final CompanyWorkersDetailsController controller =
      Get.find<CompanyWorkersDetailsController>();
  final CompanyDetailsController companyDetailscontroller =
      Get.find<CompanyDetailsController>();
  var loading = false.obs;
  var populated = false.obs;
  var expertise = [].obs;
  var isExpert = <bool>[].obs;
  var categories = <Datum>[].obs;
  var selectedExperties = <Map<String, int>>[].obs;
  var workerNameController = TextEditingController().obs;
  var workerTitleController = TextEditingController().obs;
  var workerPhoneNumberController = TextEditingController(text: "+971").obs;
  var workerWhatssappNumberController = TextEditingController(text: "+971").obs;
  var workerUserName = TextEditingController().obs;
  var workerPassword = TextEditingController().obs;
  var workerConfirmPassword = TextEditingController().obs;
  var type = "password".obs;
  var visiblePassword = false.obs;
  var visibleConfirmPassword = false.obs;
  var showwhatsApp = false.obs;
  var changePassword = false.obs;
  var errorMessage = "".obs;
  var isPlaceholderVisible = true.obs;
  var iswhatsAppPlaceholderVisible = true.obs;

  /* var worker = Worker().obs; */

  @override
  Future<void> onInit() async {
    super.onInit();
    isExpert.addAll(List.generate(expertise.length, (index) => false));
    var type = Get.arguments['type'] ?? 'add';
    /* if (type == 'edit' && !populated.value) {
      editWorker();
    } */
    await getExperties();
  }

  getExperties() async {
    loading.value = true;
    var getExpertiesRequest = await CompanyWorkersServices.getExperties();
    inspect(getExpertiesRequest!.data!);
    categories.value = getExpertiesRequest!.data!;
    if (categories != null) {
      for (int i = 0; i < categories.length; i++) {
        if (categories[i].name != null) {
          expertise.add(categories[i].name);
        }
      }
      isExpert.value =
          List.generate(expertise.length, (index) => false).toList();
    } else {
      toast(message: "Failed To Fetch Categories".tr);
    }
    loading.value = false;

    for (int i = 0;
        i < controller.workers[workerIndex].categories!.length;
        i++) {
      int idx = -1;
      categories.forEach(
        (element) {
          if (element.id == controller.workers[workerIndex].categories![i].id) {
            idx = categories.indexOf(element);
          }
        },
      );
      if (idx != -1) {
        toggleExperince(idx);
      }
    }
  }

  /*getWorkerDetails() async {
    loading.value = true;
    var getExpertiesRequest = await CompanyWorkersServices.getWorkerDetails();
    categories.value = getExpertiesRequest!.data!;
    if (categories != null) {
      for (int i = 0; i < categories.length; i++) {
        if (categories[i].name != null) {
          expertise.add(categories[i].name);
        }
      }
      isExpert.value =
          List.generate(expertise.length, (index) => false).toList();
    } else {
      toast(message: "Failed To Fetch Categories".tr);
    }
    loading.value = false;
  }*/

  toggleExperince(index) {
    isExpert[index] = !isExpert[index];
    if (isExpert[index]) {
      selectedExperties.add({"category_id": categories[index].id!});
    } else {
      selectedExperties
          .removeWhere((cat) => cat['category_id'] == categories[index].id);
    }
    inspect(selectedExperties.value);
  }

  toggleWhatsApp() {
    showwhatsApp.value = !showwhatsApp.value;
  }

  togglePassword() {
    changePassword.value = !changePassword.value;
  }

  checkValidation() {
    final isValid = companyWorkerFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  createWorker() async {
    if (checkValidation()) {
      var companyName = companyDetailscontroller.company.value.name;
      loading.value = true;
      var createAccountRequest = await CompanyWorkersServices.addWorker(
          fullName: workerNameController.value.text,
          categories: selectedExperties.value,
          title: workerTitleController.value.text,
          phone: workerPhoneNumberController.value.text,
          whats: workerWhatssappNumberController.value.text == ''
              ? null
              : workerWhatssappNumberController.value.text,
          password: workerPassword.value.text,
          passwordConfirmation: workerConfirmPassword.value.text,
          username: /*companyName! + '_' + */workerUserName.value.text);
      if (createAccountRequest.runtimeType != String) {
        toast(message: 'Worker Account Created Successfully'.tr);
        await controller.getCompanyWorkers();
        Get.back();
        loading.value = false;
      } else {
        Get.snackbar('Dublicate Entry'.tr, createAccountRequest,
            backgroundColor: ConstantColors.errorColor,
            colorText: Colors.white);
        loading.value = false;
      }
    } else {
      toast(message: 'Something Went Wrong'.tr);
      loading.value = false;
    }
  }

  editWorker(CompanyWorker worker, int index) async {
    if (checkValidation()) {
      loading.value = true;

      bool success = await CompanyWorkersServices.updateWorker(
          newWorker: worker,
          oldWorker: controller.workers[index],
          id: worker.id!,
          password: changePassword.value ? workerPassword.value.text : '',
          passwordConfirmation:
              changePassword.value ? workerConfirmPassword.value.text : '');
      if (success) {
        Get.find<CompanyWorkersDetailsController>().workers[index] = worker;
        await controller.getCompanyWorkers();
        loading.value = false;
        Get.back();
      } else {
        loading.value = false;
      }
    } else {
      toast(message: 'Something Went Wrong'.tr);
      loading.value = false;
    }
  }

  /*editWorker() async {
    populated.value = true;
    loading.value = true;
    worker.value =
        (await CompanyWorkersServices.showWorker(Get.arguments['accountId']))!;
    inspect(worker.value);
    workerNameController.value.text = worker.value.data!.bankName ?? "";
    workerTitleController.value.text = worker.value.data!.accountTitle ?? "";
    workerPhoneNumberController.value.text = worker.value.data!.iban ?? "";
    workerWhatssappNumberController.value.text =
        worker.value.data!.accountNumber ?? "";
    workerUserName.value.text = worker.value.data!.userName??"";
    loading.value = false;
  }

  

  updateWorker() async {
    if (checkValidation()) {
      loading.value = true;
      var updateAccountRequest = await CompanyWorkersServices.updateAccount(
          accountId: Get.arguments['accountId'],
          bankName: bankNameController.value.text,
          accountName: accountTitleController.value.text,
          accountNumber: accountNumberController.value.text,
          iban: ibanController.value.text);
      if (updateAccountRequest != null) {
        toast(message: "Account Updated Successfully");
        Get.back();
        await controller.getWorkers();
        loading.value = false;
      } else {
        toast(message: "Something Went Wrong");
        loading.value = false;
      }
    }
  } */
}
