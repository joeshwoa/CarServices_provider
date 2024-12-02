import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:autoflex/models/bussiness%20hours/workdays.dart';
import 'package:autoflex/services/company/working_hours_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ManageHoursController extends GetxController {
  var loading = false.obs;
  var workingHoursFormKeys = List.generate(7, (_) => GlobalKey<FormState>());
  //will be used to send to the api
  var workingHours = <Datum>[
    Datum(day: "MON"),
    Datum(day: "TUE"),
    Datum(day: "WED"),
    Datum(day: "THU"),
    Datum(day: "FRI"),
    Datum(day: "SAT"),
    Datum(day: "SUN")
  ].obs;
  //data obtained from the api
  var workDays = <Datum>[];
  var isExpanded = List.generate(7, (_) => false.obs);
  var isPopulated = List.generate(7, (_) => false.obs);
  var isChecked = List.generate(7, (_) => false.obs);
  var isSwitched = List.generate(7, (_) => false.obs);
  var hasBreak = List.generate(7, (_) => false.obs);

  var controllers = List.generate(
      7,
      (_) => [
            TextEditingController().obs,
            TextEditingController().obs,
            TextEditingController().obs,
            TextEditingController().obs,
          ]).obs;

  /*  var weekcodes = [
    {"MON": 'Monday'},
    {"TUE": 'Tuesday'},
    {"WED": 'Wednesday'},
    {"THU": 'Thursday'},
    {"FRI": 'Friday'},
    {"SAT": 'Saturday'},
    {"SUN": 'Sunday'}
  ]; */

  var weekdays = [
    'Monday'.tr,
    'Tuesday'.tr,
    'Wednesday'.tr,
    'Thursday'.tr,
    'Friday'.tr,
    'Saturday'.tr,
    'Sunday'.tr
  ].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getWorkingHours();
  }

  Future<void> getWorkingHours() async {
    loading.value = true;
    var getWorkingHoursRequest = await WorkingHoursServices.getWorkingHours();
    if (getWorkingHoursRequest == null) {
      toast(message: "Failed to fetch working hours data".tr);
    } else {
      workDays = getWorkingHoursRequest!.data!;
      for (var data in workDays) {
        var matchingDay = workingHours.firstWhere(
            (datum) => datum.day == data.day,
            orElse: () => Datum());
        if (matchingDay.day != null) {
          matchingDay.from = data.from;
          matchingDay.allDay = data.allDay;
          matchingDay.to = data.to;
          matchingDay.datumBreak = data.datumBreak;
          matchingDay.breakFrom = data.breakFrom;
          matchingDay.breakTo = data.breakTo;
        }
      }
    }
    loading.value = false;
  }

  populateDay(index) {
    isPopulated[index].value = true;
    isChecked[index].value = true;
    isSwitched[index].value = workingHours[index].allDay ?? false;
    if (!isSwitched[index].value) {
      controllers[index][0].value.text = workingHours[index].from ?? '';
      controllers[index][1].value.text = workingHours[index].to ?? '';
    }
    hasBreak[index].value = workingHours[index].datumBreak ?? false;
    if (hasBreak[index].value) {
      controllers[index][2].value.text = workingHours[index].breakFrom ?? '';
      controllers[index][3].value.text = workingHours[index].breakTo ?? '';
    }
  }

  checkValidation(index) {
    final isValid = workingHoursFormKeys[index].currentState!.validate();
    if (!isValid) {
      print('check is false');
      return false;
    } else {
      return true;
    }
  }

  addDay(index) {
    if (checkValidation(index)) {
      var matchingDay = workingHours[index];
      if (matchingDay.day != null) {
        matchingDay.allDay = isSwitched[index].value;
        if (!isSwitched[index].value) {
          matchingDay.from = controllers[index][0].value.text;
          matchingDay.to = controllers[index][1].value.text;
        }
        matchingDay.datumBreak = hasBreak[index].value;
        if (hasBreak[index].value) {
          matchingDay.breakFrom = controllers[index][2].value.text;
          matchingDay.breakTo = controllers[index][3].value.text;
        }
      }

      inspect(workingHours[index]);
      inspect(workingHours.value);
    } else {
      Get.snackbar('${weekdays[index].toUpperCase()} ${'ERROR'.tr}',
          "${'Can\'t add work day at'.tr} ${weekdays[index].toLowerCase()} ${'due to invalid inputs'.tr}",
          backgroundColor: ConstantColors.errorColor, colorText: Colors.white);
      isChecked[index].value = false;
    }
  }

  removeDay(index) {
    var matchingDay = workingHours[index];
    if (matchingDay.day != null) {
      matchingDay.from = null;
      controllers[index][0].value.text = "";
      matchingDay.allDay = false;
      isSwitched[index].value = false;
      matchingDay.to = null;
      controllers[index][1].value.text = "";
      matchingDay.datumBreak = false;
      hasBreak[index].value = false;
      matchingDay.breakFrom = null;
      controllers[index][2].value.text = "";
      matchingDay.breakTo = null;
      controllers[index][3].value.text = "";
    }
    print('removed');
    inspect(workingHours.value);
  }

  Future<void> updateWorkingHours() async {
    loading.value = true;
    var stop = false;
    var day = weekdays[0];
    for (int i = 0; i < isChecked.length; i++) {
      if (isChecked[i].value) {
        if (!checkValidation(i)) {
          stop = true;
          print('stop');
          day = weekdays[i];
          break;
        }
      }
    }

    if (!stop) {
      var body = {
        "days": workingHours
            .map((e) => {
                  "day": e.day,
                  "from": e.from,
                  "to": e.to,
                  "all_day": e.allDay ?? false,
                  "break": e.datumBreak ?? false,
                  "break_from": e.breakFrom,
                  "break_to": e.breakTo
                })
            .toList()
      };
      var updateWorkingHoursRequest =
          await WorkingHoursServices.updateWorkingHours(body);
      if (updateWorkingHoursRequest != null) {
        toast(message: 'Changes Has Been Applied'.tr);
      } else {
        toast(message: "Changes Was Not Saved".tr);
      }
    } else {
      Get.snackbar(
          "Missing Inputs".tr, "${'Please Complete The Inputs of'.tr} $day",
          backgroundColor: ConstantColors.errorColor, colorText: Colors.white);
    }
    loading.value = false;
  }
}
