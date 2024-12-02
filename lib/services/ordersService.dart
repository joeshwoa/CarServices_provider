import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/order.dart';
import 'package:autoflex/models/orders.dart';
import 'package:autoflex/services/constants.dart';

class OrdersServices {
  static Future<Orders?> getAllOrders() async {
    var response = await Constants.getNetworkService("v1/seller/order", "withToken");
       if (response.statusCode == 200 || response.statusCode == 201) {
      var result = ordersFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Orders?> getAllNewOrders() async {
    var response = await Constants.getNetworkService("v1/seller/order?status=pending", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = ordersFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<bool> editOrder({
    required int id,
    required Datum order
}) async {
    inspect(order);
    var response = await Constants.putNetworkService("v1/seller/order/$id", "withToken", order.toJson());
    return response.statusCode == 200 || response.statusCode == 201 ? true : false;
  }
    static Future<Order?> assignOrder({
    required int id,
    required workerId
}) async {
   
    var response = await Constants.putNetworkService("v1/seller/order/${id}/assign", "withToken", {
      "worker_id":workerId,
      "status":"assigned"
    });
    print(response.body);
    if(response.statusCode == 200 || response.statusCode == 201)
  {   var result = orderFromJson(response.body);
      if (result != null) {
        return result;
      }}
     else {
      return null;
    }
  }
}