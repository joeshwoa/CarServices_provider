import 'package:autoflex/controllers/Auth/success-screen.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class OtpController extends GetxController {
  var mobileNumber=''.obs;
    var otpToken = ''.obs;
  var errorMessage = ''.obs;
  var success = true.obs;
  var otpResendSuccess = false.obs;
  var timerEnd = true.obs;
  var loading = false.obs;
  var endTime = DateTime.now().millisecondsSinceEpoch.obs +
      Duration(seconds: 10).inMilliseconds;

  Future<String?> requestOtp({required String token}) async {
    if (timerEnd.value) {
      try {
        loading.value = true;
        String message = await AuthService.requestOtp(token: token,);
        toast(message: message);
        loading.value = false;
        timerEnd.value = false;
        otpResendSuccess.value = true;
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  Future<String?> verifyOtp({required String token}) async {
    if (otpToken.value.length == 4 && token.isNotEmpty) {
      try {
        loading.value = true;

        String message = await AuthService.verifyOtp(token: token, otp: otpToken.value);

        toast(message: message);
        loading.value = false;
        if(message == 'User verified successfully.'.tr|| message.contains('بنجاح')) {
          Get.offAll(() => SucessScreen(),arguments: {'type':'phoneVerified'});
        }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }
}