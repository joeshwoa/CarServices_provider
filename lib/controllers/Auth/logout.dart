import 'package:autoflex/models/login.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:get/get.dart';

import '../../services/shared_preference.dart';

class LogoutController extends GetxController {
  var pref = Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
  var loading = false.obs;

  Future<String?> logoutRequest() async {
    loading.value = true;
    var logoutRequest = await AuthService.signout();
    dynamic isLoggedIn = false;
    dynamic token = "";
    Login userData = Login();
    pref.userToken.value = token;
    pref.isLoggedIn.value = isLoggedIn;
    pref.userData.value = userData;
    loading.value = false;
    return logoutRequest['message'];
  }
}