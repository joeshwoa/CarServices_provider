import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/earning.dart';
import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/models/reviews.dart';
import 'package:autoflex/services/constants.dart';
import 'package:flutter/foundation.dart';

class HomeServices {
  static Future<Earning?> getEarning() async {
    var response =
    await Constants.getNetworkService("v1/seller/company/stat/all", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = earningFromJson(response.body);
      return result;
        } else {
      if(kDebugMode) {
        print(response.body);
      }
      return null;
    }
  }
  static Future<Notifications?> getNotifications() async {
    var response =
    await Constants.getNetworkService("v1/seller/notifications", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = notificationsFromJson(response.body);
      return result;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return null;
    }
  }
  static Future<bool> readAllNotifications() async {
    var response =
    await Constants.putNetworkService("v1/seller/notifications/read/all", "withToken", {});
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }
   static Future<Reviews?> getReviews() async {
    var response =
        await Constants.getNetworkService("v1/seller/reviews", "withToken");
        inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = reviewsFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
   
      return null;
    }
    return null;
  }
    static Future<String> witdraw() async {
    var response = await Constants.getNetworkService(
        "v1/seller/withdraw", "withToken");

    if(response.statusCode >= 200 && response.statusCode <= 300) {
      return json.decode(response.body)['message'];
    }

    return response.body;
  }
}
