import 'dart:developer';

import 'package:autoflex/models/login.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Auth/otp.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignUpController extends GetxController {
  final signUpFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  var type = "password".obs;
  var visiblePassword = false.obs;
  var visibleConfirmPassword = false.obs;
  var showwhatsApp = false.obs;
  var terms = false.obs;
  var loading = false.obs;
  var errorMessage = "".obs;
  var isPlaceholderVisible = true.obs;
  var iswhatsAppPlaceholderVisible = true.obs;
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmpasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController(text: "+971");
  TextEditingController whatsappController =
      TextEditingController(text: "+971");
  @override
  void initState() {
    isPlaceholderVisible.value = phoneController.text == "+971";
    iswhatsAppPlaceholderVisible.value = whatsappController.text == "+971";
  }

  checkValidation() {
    final isValid = signUpFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> signUpRequest() async {
    if (checkValidation() && terms.value) {
      var whatsapp;
      if (whatsappController.text == '+971') {
        whatsapp = null;
      }
      try {
        loading.value = true;
        dynamic signUpResponse = await AuthService.signUp(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
            password_confirmation: confirmpasswordController.text,
            whatsapp: null,
            phone: phoneController.text);
        loading.value = false;
        toast(message: signUpResponse['message']!);
        if (signUpResponse['errors'] == null) {
          Get.offAll(SignInScreen());
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
