import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:autoflex/models/company.dart';
import 'package:autoflex/services/constants.dart';

class CompanyServices {
  static Future<Company?> getCompany() async {
    var response =
        await Constants.getNetworkService("v1/seller/company", "withToken");
    inspect(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = companyFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
  }

  static Future<Company?> addCompany(
      {required String name,
      required String phone,
      required String address,
      required String license,
      required String logo,
      required String passport,
      required String idCard}) async {
    var response = await Constants.multipartrequestNetworkService(
        "v1/seller/company", "withToken", {
      "name": name,
      "phone": phone,
      "address": address,
    }, [
      {
        'logo': logo,
      },
      {'passport': passport},
      {'owner_emirates_id': idCard},
      {'trade_license': license}
    ]);
    print(response!.body);
    var result = null;
    if (response?.statusCode == 200 || response?.statusCode == 201) {
      result = companyFromJson(response!.body);
    } else {
      inspect("SOMETHING WENT WRONG IN THE ADD COMPANY");
    }
    if (result != null) {
      return result;
    } else
      return null;
  }

  static Future<Company?> updateCompany(
      {required String name,
      required String phone,
      required String address,
      String? license,
      String? logo,
      String? passport,
      String? idCard}) async {
    List<Map<String, String>> body = [];
    if (license != '') {
      body.add({'trade_license': license!});
    }
    if (logo != '') {
      body.add({'logo': logo!});
    }
    if (passport != '') {
      body.add({'passport': passport!});
    }
    if (idCard != '') {
      body.add({'owner_emirates_id': idCard!});
    }
    var response = await Constants.multipartrequestNetworkService(
        "v1/seller/company/update",
        "withToken",
        {
          "name": name,
          "phone": phone,
          "address": address,
        },
        body);
    var result = null;

    if (response?.statusCode == 200 || response?.statusCode == 201) {
      inspect(response?.body);
      result = companyFromJson(response!.body);
    } else {
      inspect("SOMETHING WENT WRONG IN THE UPDATE COMPANY");
    }
    if (result != null) {
      return result;
    } else
      return null;
  }
}
