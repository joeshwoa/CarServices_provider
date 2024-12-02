import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iban/iban.dart';

class Validations {
  static String? validateName(String name, BuildContext context) {
    String? validateString;
    Pattern pattern = r'[a-zA-Zء-ي]';
    RegExp regex = RegExp(pattern.toString());
    if (name.trim().isEmpty) {
      validateString = "Name must not be empty".tr;
    } else if (!regex.hasMatch(name.trim()) ||
        name.trim().length < 2 ||
        name.trim().length >= 15) {
      validateString = "Please enter a valid name".tr;
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateOrganizationName(String name, BuildContext context) {
    String? validateString;
    Pattern pattern = r'[a-zA-Zء-ي]';
    RegExp regex = RegExp(pattern.toString());
    if (name.trim().isEmpty) {
      validateString = "Organization name must not be empty".tr;
    } else if (!regex.hasMatch(name.trim()) ||
        name.trim().length < 2 ||
        name.trim().length >= 15) {
      validateString = "Please enter a valid name".tr;
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateEmail(String email, BuildContext context) {
    String? validateString;
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = RegExp(pattern.toString());
    if (email.trim().isEmpty) {
      validateString = "Email must not be empty".tr;
    } else if (!regex.hasMatch(email.trim())) {
      validateString = "Please enter a valid email".tr;
    }
    return validateString;
  }

  static String? validatePhone(String phone, BuildContext context) {
    String? validateString = '';
    if (phone.trim().isEmpty) {
      validateString = "Phone number must not be empty".tr;
    } else if (phone.trim().length != 13) {
      validateString = "Please enter a valid phone number".tr;
    } else if (!phone.startsWith("+971")) {
      validateString = "Please enter a valid phone number".tr;
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? vaidatePhoneEg(String value, BuildContext context) {
    //String pattern = r'^(^\+9665[5|0|3|6|4|9|1|8|7]{1}[0-9]{7})$';
    String patternEg = r'^([0]1[0-2|5]{1}[0-9]{8})$';
    String? validateString = '';
    RegExp regExp = RegExp(patternEg);
    if (value.isEmpty) {
      validateString = "Phone must not be empty".tr;
      return validateString;
    } else if (!(RegExp(patternEg).hasMatch(value))) {
      validateString = "Please enter a valid phone number".tr;
      return validateString;
    }
  }

  static String? validateOTP(String value, BuildContext context) {
    //String pattern = r'^(^\+9665[5|0|3|6|4|9|1|8|7]{1}[0-9]{7})$';
    String pattern = r"^[0-9]$";
    String? validateString = '';
    RegExp regExp = RegExp(pattern);
    if (value.isEmpty) {
      validateString = "Phone must not be empty".tr;
      return validateString;
    } else if (!(RegExp(pattern).hasMatch(value))) {
      validateString = "Please enter a number".tr;
      return validateString;
    }
  }

  static String? validatePrice(String value, BuildContext context) {
    // Regular expression to match either integer or decimal number
    String pattern = r'^(\d+(\.\d+)?)$';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      return "Price must not be empty".tr;
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid number".tr;
    }
    return null; // Return null if the input is valid
  }

  static String? validateRequired(String value, BuildContext context) {
    // Regular expression to match either integer or decimal number
    if (value.isEmpty) {
      return "Field Must Not Be Empty".tr;
    }
    return null; // Return null if the input is valid
  }

  static String? validateAccountNum(String value, BuildContext context) {
    String pattern = r"^[0-9]{15}$";
    String? validateString = '';
    RegExp regExp = RegExp(pattern);

    if (value.isEmpty) {
      validateString = "Phone must not be empty".tr;
      return validateString;
    } else if (!regExp.hasMatch(value)) {
      validateString = "Please enter a 15-digit number".tr;
      return validateString;
    }
    return null; // Return null if the input is valid
  }

  static String? validateIBAN(String value, BuildContext context) {
    String? validateString = '';
    if (value.isEmpty) {
      validateString = "IBAN must not be empty".tr;
      return validateString;
    } else if (!isValid(value)) {
      validateString = "Invalid IBAN".tr;
      return validateString;
    }
    return null; // Return null if the input is valid
  }

  static String? validatePassword(String password, BuildContext context) {
    String? validateString;
    // String pattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$"';
    String pattern = r"^(?:(?![\x00-\x7F]).)*(?![\s]).{8,15}$";
    RegExp regex = RegExp(pattern.toString());
    if (password.trim().isEmpty) {
      validateString = "Password must not be empty".tr;
    } else if (!regex.hasMatch(password.trim())) {
      validateString = "This field must be at least 8 characters.".tr;
    }
    return validateString;
  }

  static String? validateCompanRegister(String number, BuildContext context) {
    String? validateString;

    if (number.length < 5 || number.length > 14) {
      validateString =
          "This field must be at least 5 numbers and not be greater than 14 numbers."
              .tr;
    }
    return validateString;
  }

  static String? validateTaxRegister(String number, BuildContext context) {
    String? validateString;
    final valueWithoutHyphens = number.replaceAll('-', '');
    if (valueWithoutHyphens.length != 9) {
      validateString = "This field must be 9 numbers".tr;
    }
    return validateString;
  }

  static String? validateField(String value, BuildContext context) {
    String? validateString = '';
    // Pattern pattern ="/^[0-9]{0,2}/";
    // RegExp regex = RegExp(pattern.toString());
    if (value.trim().isEmpty) {
      validateString = "This field must not be empty".tr;
    }
    //   else if (!regex.hasMatch(value.trim())) {
    //   validateString = "";

    // }
    else {
      validateString = null;
    }
    return validateString;
  }

  static String? validatePowerConsumption(String value, BuildContext context) {
    String? validateString = '';
    Pattern pattern = r"^[0-9.]+$";
    RegExp regex = RegExp(pattern.toString());
    if (value.trim().isEmpty) {
      validateString = "This field must not be empty".tr;
    } else if (!regex.hasMatch(value.trim())) {
      validateString = "This field does not accept special characters".tr;
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateHours(String value, BuildContext context) {
    String? validateString = '1';
    // Pattern for time format HH:MM
    String pattern = r'^([01]\d|2[0-3]):([0-5]\d)$';

    if (value.trim().isEmpty) {
      validateString = "This field must not be empty".tr;
    } else if (!(RegExp(pattern).hasMatch(value))) {
      validateString = "Please enter a valid time in HH:MM format".tr;
    } else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateTime(String value, BuildContext context) {
    String? validateString;

    String pattern = r'^(0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$';

    if (value.trim().isEmpty) {
      validateString = "This field must not be empty".tr;
    } else if (!RegExp(pattern).hasMatch(value)) {
      validateString = "Invalid time format. Please use HH:MM format".tr;
    } else {
      validateString = null;
    }

    return validateString;
  }

  static String? validateUrl(String value, BuildContext context) {
    String? validateString = '1';
    String pattern =
        r"^(http(s)?:\/\/)[\w.-]+(?:\.[\w\.-]+)+[\w\-\._~:/?#[\]@!\$&'\(\)\*\+,;=.]+$";

    if (value.trim().isEmpty) {
      validateString = "This field must not be empty".tr;
    } else if (!(RegExp(pattern).hasMatch(value))) {
      validateString = "please enter valid url".tr;
    }
    //   else if (!regex.hasMatch(value.trim())) {
    //   validateString = "";

    // }
    else {
      validateString = null;
    }
    return validateString;
  }

  static String? validateconfirmPassword(
      String password, BuildContext context, String confirmpass) {
    String? validateString;

    if (confirmpass.trim().isEmpty) {
      validateString = "Confirm password must not be empty".tr;
    } else if (password.toString() != confirmpass.toString()) {
      validateString = "Confirm password doesn't match".tr;
    }
    return validateString;
  }

  static String? validatenewPassword(
      String oldPassword, BuildContext context, String newPassword) {
    String? validateString;

    if (newPassword.trim().isEmpty) {
      validateString = "Confirm password must not be empty".tr;
    } else if (oldPassword.toString() == newPassword.toString()) {
      validateString = "New password shouldn't match old password".tr;
    } else if (newPassword.length < 8) {
      validateString = "This field must be at least 8 characters".tr;
    }
    return validateString;
  }
}
