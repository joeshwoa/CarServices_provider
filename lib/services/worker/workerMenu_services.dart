import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/company%20workers/WorkerDetails.dart';
import 'package:autoflex/services/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class WorkerMenuServices {
  static Future<WorkerDetails?> getWorkerDetails() async {
    var response =
    await Constants.getNetworkService("v1/worker/get", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = workerDetailsFromJson(response.body);
      return result;
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return null;
    }
  }

  static Future<List<dynamic>> updateWorkerDetails(WorkerDetails workerDetails, WorkerDetails oldWorkerDetails) async {

    Map<String, String> body = {};
    List<Map<String, String>> images = [];


    Map<String, dynamic> workerMap = json.decode(workerDetailsToJson(workerDetails))['data'];
    Map<String, dynamic> oldWorkerMap = json.decode(workerDetailsToJson(oldWorkerDetails))['data'];

    oldWorkerMap.forEach((String key, dynamic value) {
      if(value != workerMap[key]) {
        body.addAll({
          key: workerMap[key].toString(),
        });
      }
    },);

    if(body.isEmpty) {
      return [false, 'No new worker information'.tr];
    }
    
    if(body.containsKey('image')) {
      body.remove('image');
      images.add({
        'image': workerMap['image'],
      });
    }

    var response =
    await Constants.multipartrequestNetworkService("v1/worker/update", "withToken",body, images);
    inspect(response!.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return [true, 'Worker details updates successfully'.tr, workerDetailsFromJson(response.body)];
    } else {
      if(kDebugMode) {
        print(response.body);
      }
      return [false, response.body];
    }
  }
}
