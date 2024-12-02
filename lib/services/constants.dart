import 'dart:convert';
import 'dart:developer';

import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'shared_preference.dart';

class Constants {
  //EDIT TO REMOVE CHUCKER
  static var client = ChuckerHttpClient(http.Client());
  static const String baseUrl = 'https://autoflex.innovationbox.ae';
  static const String apiKey = 'https://autoflex.innovationbox.ae/api';
  static Map<String, String> headers = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'iso':
        Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
            .localization
            .value
  };
  static Map<String, String> headersWithToken = {
    'Accept': 'application/json',
    'Content-type': 'application/json',
    'Authorization':
        'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}',
    'iso': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
        .localization
        .value
  };
  static Future<http.Response> getNetworkService(
      String api, String headersType) {
         print(headers);
    if (kDebugMode) {
      // print(headersWithToken);
    }
    return client.get(Uri.parse('$apiKey/$api'),
        headers: headersType == "withToken" ? headersWithToken : headers);
  }

  static Future<http.Response> postNetworkService(
      String api, String headersType, Map<String, dynamic> body) {
        print(headers);
    return client.post(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response> putNetworkService(
      String api, String headersType, Map<String, dynamic> body) {
    return client.put(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response> deleteNetworkService(
      String api, String headersType, Map<String, dynamic> body) {
    return client.delete(
      Uri.parse('$apiKey/$api'),
      headers: headersType == "withToken" ? headersWithToken : headers,
      body: json.encode(body),
    );
  }

  static Future<http.Response?> multipartrequestNetworkService(
    String api,
    String headersType,
    Map<String, String> body,
    List<Map<String, String>> images,
  ) async {
    try {
      var request = http.MultipartRequest("POST", Uri.parse('$apiKey/$api'));
      for (var i = 0; i < images.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath(
            images[i].keys.first, images[i].values.first);
        request.files.add(multipartFile);
      }
      request.headers
          .addAll(headersType == "withToken" ? headersWithToken : headers);

      request.fields.addAll(body);
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (kDebugMode) {
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
      // final respStr = await response.
      if (kDebugMode) {
        print("response");
        print(response);
      }
      return response;
    } catch (err) {
      if (kDebugMode) {
        print("err");
        print(err);
      }
    }
    return null;
  }

  static Future<http.Response> postNetworkServiceWithOptionalToken(
      String api, String headersType, Map<String, dynamic> body
      , {String? optionalToken }
      ){

    return client.post(
      Uri.parse('$apiKey/$api'),

      headers:  {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
        'Bearer $optionalToken',
        'lang': Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere')
            .localization
            .value
      },

      body: json.encode(body),
    );
  }
}
