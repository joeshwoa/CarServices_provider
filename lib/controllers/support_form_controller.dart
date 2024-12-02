
import 'package:autoflex/services/support_from_service.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:autoflex/views/deleted_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportController extends GetxController {
  final supportFormKey = GlobalKey<FormState>();
  var isPlaceholderVisible = true.obs;
  var loading = false.obs;
  TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  var buttonEnable = false.obs;

  var reasons = [
    'complaint'.tr,
    'donation'.tr,
    'techical support'.tr,
    'report'.tr,
    'feedback'.tr
  ].obs;

  var selectedReason = ''.obs;

  selectReason(reason) {
    selectedReason.value = reason;
  }

  @override
  void onInit() {
    super.onInit();
    isPlaceholderVisible.value = phoneController.text == "+971";
  }

  checkValidation() {
    final isValid = supportFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  updateButtonEnable() {
    buttonEnable.value = !(emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        messageController.text.isEmpty ||
        nameController.text.isEmpty ||
        selectedReason.value.isEmpty);
  }

  Future<String?> deleteAccountRequest() async {
    if (checkValidation()) {
      Get.to(() => const DeletedScreen());
      try {} catch (e) {
        print(e);
      }
    }
    return null;
  }

  Future<void> submitTalkToUsMessageRequest() async {
    if (checkValidation()) {
      try {
        loading.value = true;
        bool postMessageRequest = await SupportFromService.postMessage(nameController.text, selectedReason.value, emailController.text, messageController.text, phoneController.text);
        loading.value = false;
        if(postMessageRequest) {
          toast(message: 'Message sent successfully'.tr);
          phoneController.clear();
          nameController.clear();
          emailController.clear();
          messageController.clear();
          selectedReason.value = '';
          updateButtonEnable();
          Get.to(HomeScreen());
        }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
    return null;
  }
}
