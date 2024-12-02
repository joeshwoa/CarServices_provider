import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/notifications.dart';
import 'package:autoflex/models/workerHome/woker_orders.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/constants.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WorkerHomeOfflineServices {
  static Future<WorkerOrders> getOrders({bool todayJobs = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    WorkerOrders response = workerOrdersFromJson(prefs.getString('WorkerOrders')??'{"data": []}');

    List<Datum> orders = response.data!.where((element) => todayJobs ? (element.date!.year == DateTime.now().year && element.date!.month == DateTime.now().month && element.date!.day == DateTime.now().day) : element.date!.isAfter(DateTime.now()) && DateTime.now().day != element.date!.day,).toList();

    return WorkerOrders(data: orders);
    //return response;
  }

  /*static Future<Notifications?> getNotifications() async {
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
    await Constants.postNetworkService("v1/worker/notifications/read/all", "withToken", {});
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return false;
    }
  }*/

  static Future<void> updateOrderStatus(int orderId, String status) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String> updateOrderStatusQueue = prefs.getStringList(
        'updateOrderStatusQueue') ?? [];

    updateOrderStatusQueue.addNonNull(jsonEncode({
      "orderId": "$orderId",
      "status": "$status"
    }));

    prefs.setStringList('updateOrderStatusQueue', updateOrderStatusQueue);
    WorkerOrders response = workerOrdersFromJson(prefs.getString('WorkerOrders')??'{"data": []}');
    int index = response.data!.indexWhere((element) => element.id == orderId,);
    if (index!= -1) {
      response.data![index].status = status;
    }
    prefs.setString('WorkerOrders', workerOrdersToJson(response));
    toast(message: 'order status updated successfully.'.tr);
  }
}
