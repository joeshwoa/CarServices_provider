import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/otp.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkerController extends GetxController {
  final workerFormKey = GlobalKey<FormState>();

  var expertise = [].obs;

  var isExpert = <bool>[].obs;

  var type = "password".obs;
  var visiblePassword = false.obs;
  var visibleConfirmPassword = false.obs;
  var showwhatsApp = false.obs;
  var loading = false.obs;
  var errorMessage = "".obs;
  var isPlaceholderVisible = true.obs;
  var iswhatsAppPlaceholderVisible = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController whatsappController =
      TextEditingController(text: "+971");
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();

  var populated = false.obs;

  @override
  void onInit() {
    super.onInit();
    isExpert.addAll(List.generate(expertise.length, (index) => false));
  }

  editWorker() {
    Map<String, dynamic> worker = {
      'name': 'full name',
      'pfp': avatar,
      'username': 'companyName_username',
      'title': 'wash expert',
      'phone': '+971581895',
      'expertise': ['car wash', 'AC Service']
    };

    nameController.text = worker['name'];
    titleController.text = worker['title'];
    phoneController.text = worker['phone'];
    if (worker['whatsapp'] != null) {
      showwhatsApp.value = true;
      whatsappController.text = worker['whatsapp'];
    }
    usernameController.text = worker['username'];

    for (var exp in worker['expertise']) {
      int index = expertise.indexOf(exp);
      if (index != -1) {
        isExpert[index] = true;
      }
    }
    populated.value = true;
  }

  checkValidation() {
    final isValid = workerFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  addWorker() {
    if (checkValidation()) {
      Get.to(() => ManageWorkersScreen());
      try {} catch (e) {
        print(e);
      }
    }
  }
}
