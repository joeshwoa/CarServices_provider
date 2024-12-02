import 'dart:developer';

import 'package:autoflex/models/work%20areas/areas.dart';
import 'package:autoflex/models/work%20areas/service_areas.dart';
import 'package:autoflex/models/work%20areas/work_areas.dart';
import 'package:autoflex/services/constants.dart';

class WorkingAreasServices {
  static Future<Areas?> getAreas(emirateId) async {
    var response = await Constants.getNetworkService(
        "v1/cities?emirate_id=$emirateId", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = areasFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<WorkAreas?> getWorkAreas() async {
    var response =
        await Constants.getNetworkService("v1/seller/area", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = workAreasFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  //Endpoint to be updated
  static Future<ServiceAreas?> getWorkAreasInfo() async {
    var response =
        await Constants.getNetworkService("v1/seller/area/all", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = serviceAreasFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<WorkAreas?> updateAreas({required List<Datum> areas}) async {
    var response =
        await Constants.postNetworkService("v1/seller/area", "withToken", {
      "area": areas
          .map((e) => {
                "city_id": e.cityId,
                "emirate_id": e.emirateId,
                "reach_time": e.reachTime
              })
          .toList()
    });
    var result;
    inspect(response.body);
    if (response.statusCode == 200 || response?.statusCode == 201) {
      result = workAreasFromJson(response!.body);
    } else {
      inspect("SOMETHING WENT WRONG IN THE BLOCK DATES");
    }
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }
}
