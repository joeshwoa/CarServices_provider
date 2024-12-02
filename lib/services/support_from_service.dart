import 'dart:convert';

import 'package:autoflex/services/constants.dart';


class SupportFromService {
  static Future<bool>postMessage(String name, String reason, String email, String message, String phone) async {
    var response = await Constants.postNetworkService(
        "v1/seller/talks", "withToken", {
      "name":name,
      "reason":reason,
      "email":email,
      "message":message,
      "phone":phone
    });
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

}