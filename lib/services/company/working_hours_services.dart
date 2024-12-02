import 'dart:convert';
import 'dart:developer';

import 'package:autoflex/models/bussiness%20hours/blockedDates.dart';
import 'package:autoflex/models/bussiness%20hours/workdays.dart';
import 'package:autoflex/services/constants.dart';

class WorkingHoursServices {
  static Future<BlockedDates?> getBlockedDates() async {
    var response = await Constants.getNetworkService(
        "v1/seller/availability/blocks", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = blockedDatesFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<WorkDays?> getWorkingHours() async {
    var response = await Constants.getNetworkService(
        "v1/seller/availability", "withToken");
    print(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = workDaysFromJson(response.body);
      inspect(result);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<BlockedDates?> blockDates({required List<Date> dates}) async {
    var response = await Constants.postNetworkService(
        "v1/seller/availability/blocks", "withToken", {
      "days": dates
          .map((e) => {
                "day": e.day,
                "date": e.date,
              })
          .toList()
    });
    BlockedDates? result;
    inspect(response.body);
    if (response.statusCode == 200 || response?.statusCode == 201) {
      result = blockedDatesFromJson(response!.body);
    } else {
      inspect("SOMETHING WENT WRONG IN THE BLOCK DATES");
    }
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  static Future<BlockedDates?> updateWorkingHours(body) async {
    var response = await Constants.putNetworkService(
        "v1/seller/availability", "withToken", body);

    inspect(response.body);
    BlockedDates? result;
    if (response.statusCode == 200 || response?.statusCode == 201) {
      result = blockedDatesFromJson(response!.body);
    } else {
      print("SOMETHING WENT WRONG WHILE UPDATING BUSSINESS HOURS");
    }
    if (result != null) {
      return result;
    } else {
      return null;
    }
  }

  static Future<BlockedDates?> clearblockDates(
      {required List<Date> dates}) async {
    var response = await Constants.deleteNetworkService(
        "v1/seller/availability/blocks", "withToken", {});
    BlockedDates? result;
    inspect(response.body);
    if (response.statusCode == 200 || response?.statusCode == 201) {
      result = blockedDatesFromJson(response!.body);
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
