import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/models/workerHome/woker_orders.dart';
import 'package:autoflex/services/constants.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerHomeServices {
  static Future<WorkerOrders?> getOrders({bool todayJobs = false, bool pastJobs = false, bool futureJobs = false,}) async {
    var response =
    await Constants.getNetworkService("v1/worker/orders?${todayJobs?"today=":pastJobs?"past=":futureJobs?"future=":""}${ DateFormat('yyyy-MM-dd').format(DateTime.now())}", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = workerOrdersFromJson(response.body);
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
    await Constants.getNetworkService("v1/worker/notifications", "withToken");
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
    await Constants.putNetworkService("v1/worker/notifications/read/all", "withToken", {});
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

  static Future<bool> updateOrderStatus(int orderId, String status) async {
    var response =
    await Constants.putNetworkService("v1/worker/orders/$orderId", "withToken", {
      'status': status
    });
    inspect(response.body);
    toast(message: jsonDecode(response.body)['message']);
    if (response.statusCode == 200 || response.statusCode == 201) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      WorkerOrders response = workerOrdersFromJson(prefs.getString('WorkerOrders')??'{"data": []}');
      int index = response.data!.indexWhere((element) => element.id == orderId,);
      if (index!= -1) {
        response.data![index].status = status;
      }
      prefs.setString('WorkerOrders', workerOrdersToJson(response));
      return true;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }
}
