import 'dart:convert';

import 'package:autoflex/services/constants.dart';

class TermsAndConditionsService {
  static Future<String?>getTermsAndConditions() async {
    var response = await Constants.getNetworkService(
        "v1/terms", "withToken");
    if (response.statusCode == 200 || response.statusCode == 201) {
      return json.decode(response.body)['data']['description'];
    } else {
      return null;
    }
  }

}