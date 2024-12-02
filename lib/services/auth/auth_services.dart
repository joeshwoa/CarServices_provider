import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:autoflex/firebase_api.dart';
import 'package:autoflex/models/login.dart';
import 'package:autoflex/services/constants.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

final SharedPreferenceController sharedPreferenceController =
    Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');

class AuthService {
  static Future<dynamic> signUp({
    required String name,
    // required String lastName,
    required String email,
    required String password,
    required String password_confirmation,
    required String phone,
    String? whatsapp,
  }) async {
    var response = await Constants.postNetworkService(
        "v1/seller/register", "withoutToken", {
      "full_name": name,
      "email": email,
      "password": password,
      "password_confirmation": password_confirmation,
      "phone": phone,
      "whatsapp_number": whatsapp,
      "fcm_token": FirebaseApi.token
    });
    print(response.body);
    var result = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      result = jsonDecode(response.body);
    } else {
      print("ERROR AT SIGN IN");
      inspect(result);
    }
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<Login?> meData() async {
    var response =
        await Constants.getNetworkService("v1/seller/get", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = loginFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }
/*
  static Future<SignUp?> editProfile({
    String? name,
    String? gender,
    String? dateOfBirth,
    String? email,
    String? phone,
    String? whatsapp,
    dynamic? image,
    required String? type,
  }) async {
    var response;

    switch (type) {
      case 'name':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "full_name": name,
        });
        break;
      case 'email':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "email": email,
        });
        break;
      case 'phone':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "phone": phone,
        });
        break;
      case 'whatsapp':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "whatsapp_number": whatsapp,
        });
        break;
      case 'gender':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "gender": gender,
        });
        break;
      case 'dob':
        response = await Constants.postNetworkService(
            "v1/customer/profile?_method=PUT", "withToken", {
          "date_of_birth": dateOfBirth,
        });
        break;
      case 'image':
        //  var multipartFile = await http.MultipartFile.fromPath("image", image!);
        response = await Constants.multipartrequestNetworkService(
          "v1/customer/profile?_method=PUT",
          "withToken",
          image,
        );
        break;
    }
    print(response.body);

    var result = signUpFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  } */

  static Future<Login?> sigIn({
    required String email,
    required String password,
    required String role,
  }) async {
    var response;
    if (role == 'Worker'.tr) {
      //TODO: ADD WORKERS URI
      response = await Constants.postNetworkService(
          "v1/worker/login", "withoutToken", {
        "username": email,
        "password": password,
        "device_name": await sharedPreferenceController.getValue('uuid'),
        "fcm_token": FirebaseApi.token
      });
    } else {
      response = await Constants.postNetworkService(
          "v1/seller/login", "withoutToken", {
        "email": email,
        "password": password,
        "device_name": await sharedPreferenceController.getValue('uuid'),
        "fcm_token": FirebaseApi.token
      });
    }

    var result = loginFromJson(response.body);
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<String> forgetPasswordRequest({required String email}) async {
    var response = await Constants.postNetworkService(
        "v1/seller/forgot-password", "withoutToken", {
      "email": email,
    });

    return json.decode(response.body)['message'];
  }

  static Future<String> refreshNotToken({
    required String role,
  }) async {
    var response = (role == 'Worker'.tr)
        ? await Constants.postNetworkService("v1/worker/token/refresh",
            "withToken", {"fcm_token": FirebaseApi.token})
        : await Constants.postNetworkService("v1/seller/token/refresh",
            "withToken", {"fcm_token": FirebaseApi.token});

    return json.decode(response.body)['message'];
  }

  static Future<String> verifyOtp({
    required String token,
    required String otp,
  }) async {
    var response = await Constants.postNetworkServiceWithOptionalToken(
        "v1/seller/verify",
        "withToken",
        {
          "otp": otp,
        },
        optionalToken: token);
    print(token);
    print(response.body);

    return json.decode(response.body)["message"];
  }

  static Future<String> requestOtp({
    required String token,
  }) async {
    var response = await Constants.postNetworkServiceWithOptionalToken(
        "v1/seller/send/otp", "withToken", {},
        optionalToken: token);
    print(response.body);

    return json.decode(response.body)["message"];
  }

  /* static Future<dynamic> signout() async {
    var response =
        await Constants.postNetworkService("v1/seller/logout", "withToken", {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      } else {
        return null;
      }
    } else {
      return 'an error occoured ${response.statusCode}';
    }
  } */
  static Future<dynamic?> signout() async {
    var response =
        await Constants.postNetworkService("v1/seller/logout", "withToken", {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      } else {
        return null;
      }
    } else {
      return 'an error occoured ${response.statusCode}';
    }
  }

  static Future<dynamic?> signoutWorker() async {
    var response =
        await Constants.postNetworkService("v1/worker/logout", "withToken", {});

    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      } else {
        return null;
      }
    } else {
      return 'an error occoured ${response.statusCode}';
    }
  }
}
