import 'package:autoflex/controllers/Company_data/bussines%20hours/manage_hours_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WorkingHoursValidations {
  static String? validateWorkingHours(
      String value, BuildContext context, int? index, bool isSwitched) {
    String? validateString;
    String pattern = r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$';

    if (value.trim().isEmpty && !isSwitched) {
      validateString = "This field must not be empty".tr;
    } else if (!RegExp(pattern).hasMatch(value) && !isSwitched) {
      validateString = "Invalid time format. Please use HH:MM format".tr;
    } else {
      validateString = null;
    }

    return validateString;
  }

  static String? validateBreakHours(
      String value, BuildContext context, int? index, bool hasBreak) {
    String? validateString;
    String pattern = r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$';

    if (value.trim().isEmpty && hasBreak) {
      validateString = "This field must not be empty".tr;
    } else if (!RegExp(pattern).hasMatch(value) && hasBreak) {
      validateString = "Invalid time format. Please use HH:MM format".tr;
    } else {
      validateString = null;
    }

    return validateString;
  }
}
