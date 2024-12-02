import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/models/bank/bank_accounts.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/models/products/catalogue.dart';
import 'package:autoflex/services/constants.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class CompanyWorkersServices {
  static Future<Catalogue?> getExperties() async {
    var response = await Constants.getNetworkService("v1/categories", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = catalogueFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  /*static Future<Catalogue?> getWorkerDetails() async {
    var response = await Constants.getNetworkService("v1/categories", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = catalogueFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }*/

  static Future<CompanyWorkers?> getCompanyWorkers() async {
    var response =
        await Constants.getNetworkService("v1/seller/worker", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.body);
      var result = companyWorkersFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      inspect("SOMETHING WENT WRONG IN GET ACCOUNTS");
      return null;
    }
    return null;
  }

  static Future<CompanyWorkers?> getCompanyWorkerswithfilter(
      String? service, String? date) async {
    var response = await Constants.getNetworkService(
        "v1/seller/worker?service=${service}&date=${date}", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = companyWorkersFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      inspect("SOMETHING WENT WRONG IN GET ACCOUNTS");
      return null;
    }
    return null;
  }

  static Future<dynamic> addWorker({
    required String fullName,
    required List<Map<String, int>> categories,
    required String title,
    required String phone,
    String? whats,
    required String password,
    required String passwordConfirmation,
    required String username,
  }) async {
    Map<String, dynamic> body = {
      "full_name": fullName,
      "title": title,
      "phone": phone,
      "password": password,
      "password_confirmation": passwordConfirmation,
      "username": username,
      "categories": categories
    };

// Conditionally add 'whatsapp_number' if 'whats' is not null
    if (whats != null && whats != '+971') {
      body["whatsapp_number"] = whats;
    }

    var response = await Constants.postNetworkService(
      "v1/seller/worker",
      "withToken",
      body,
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      }
    } else if (response.statusCode == 422) {
      var result = jsonDecode(response.body);
      inspect(result['message']);
      return result['message'];
    } else {
      return null;
    }
    return null;
  }

  /*
  static Future<Worker?> showWorker(accountId) async {
    var response = await Constants.getNetworkService(
        "v1/seller/worker/$accountId", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = workerFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }
*/
  static Future<bool> updateWorker({
    required CompanyWorker newWorker,
    required CompanyWorker oldWorker,
    required int id,
    String password = '',
    String passwordConfirmation = '',
  }) async {
    Map<String, dynamic> workerJson = newWorker.toJson();
    Map<String, dynamic> oldWorkerJson = oldWorker.toJson();
    if (password.isNotEmpty && passwordConfirmation.isNotEmpty) {
      workerJson.addAll({
        "password": password,
        "password_confirmation": passwordConfirmation,
      });
    }
    List<String> removedKeys = [];
    workerJson.forEach(
      (key, value) {
        if (oldWorkerJson.containsKey(key)) {
          if (value == oldWorkerJson[key]) {
            print(key);
            removedKeys.add(key);
          }
        }
      },
    );
    for (var key in removedKeys) {
      workerJson.remove(key);
    }

    if(workerJson.containsKey('categories')) {
      for (int i = 0; i < workerJson['categories'].length; i++) {
        (workerJson['categories'][i] as Map<String, dynamic>).addAll({
          "category_id": workerJson['categories'][i]['id'],
        });
        workerJson['categories'][i].remove('id');
        workerJson['categories'][i].remove('name');
        workerJson['categories'][i].remove('slug');
      }
    }

    var response = await Constants.putNetworkService(
        "v1/seller/worker/$id", "withToken", workerJson);
    inspect(response.statusCode);
    return response.statusCode == 200 || response.statusCode == 201
        ? true
        : false;
  }

  static Future<dynamic> deleteWorker(accountId) async {
    var response = await Constants.deleteNetworkService(
        "v1/seller/worker/$accountId", "withToken", {});
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = jsonDecode(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }
}
