import 'dart:convert';

import 'package:autoflex/services/constants.dart';

class FAQsService {
  static Future<List<dynamic>?>getFAQs() async {
    var response = await Constants.getNetworkService(
        "v1/faqs", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body)['data'];
    } else {
      return null;
    }
  }

}