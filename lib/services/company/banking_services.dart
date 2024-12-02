import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:autoflex/models/bank/bank_account.dart';
import 'package:autoflex/models/bank/bank_accounts.dart';
import 'package:autoflex/services/constants.dart';

class BankingServices {
  static Future<Accounts?> getAccounts() async {
    var response =
        await Constants.getNetworkService("v1/seller/bank", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = accountsFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      inspect("SOMETHING WENT WRONG IN GET ACCOUNTS");
      return null;
    }
    return null;
  }

  static Future<Account?> showAccount(accountId) async {
    var response = await Constants.getNetworkService(
        "v1/seller/bank/$accountId", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = accountFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<Account?> addAccount({
    required String bankName,
    required String accountName,
    required String accountNumber,
    required String iban,
  }) async {
    var response =
        await Constants.postNetworkService("v1/seller/bank", "withToken", {
      "bank_name": bankName,
      "account_title": accountName,
      "account_number": accountNumber,
      "iban": iban,
    });
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = accountFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<Account?> updateAccount({
    required String bankName,
    required String accountName,
    required String accountNumber,
    required String iban,
    required int accountId,
  }) async {
    var response = await Constants.putNetworkService(
        "v1/seller/bank/$accountId", "withToken", {
      "bank_name": bankName,
      "account_title": accountName,
      "account_number": accountNumber,
      "iban": iban,
    });
    inspect(response.statusCode);
    if (response.statusCode == 200 || response.statusCode == 201) {
      var result = accountFromJson(response.body);
      if (result != null) {
        return result;
      }
    } else {
      return null;
    }
    return null;
  }

  static Future<dynamic> deleteAccount(accountId) async {
    var response = await Constants.deleteNetworkService(
        "v1/seller/bank/$accountId", "withToken", {});
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
