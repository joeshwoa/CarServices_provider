import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
 final forgetPasswordFormKey = GlobalKey<FormState>();
 
  var loading = false.obs;
  var errorMessage = "".obs;

  TextEditingController emailController = TextEditingController();

  checkValidation() {
    final isValid = forgetPasswordFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }
 Future<void> forgetPasswordRequest() async {
   if (checkValidation()) {
     try {
       loading.value = true;

       String? forgetPasswordRequest = await AuthService.forgetPasswordRequest(
         email: emailController.text,);
       // return '';
       //not valid in arabic
       print(forgetPasswordRequest);
       if (forgetPasswordRequest == "We have e-mailed your password reset link!".tr) {
         loading.value = false;
         errorMessage.value = "";
         toast(message: forgetPasswordRequest.tr);
         Get.offAll(() => SignInScreen());
       } else {
         toast(message: forgetPasswordRequest.tr);
         loading.value = false;
       }
       // }
     } catch (e) {
       if (kDebugMode) {
         loading.value = false;
         print(e);
       }
     }
   }
 }
}