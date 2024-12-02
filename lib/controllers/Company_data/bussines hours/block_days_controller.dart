import 'dart:developer';
import 'dart:ffi';

import 'package:autoflex/models/bussiness%20hours/blockedDates.dart';
import 'package:autoflex/services/company/working_hours_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BlockDaysController extends GetxController {
  var loading = false.obs;
  var blocking = false.obs;
  var blockedDates = <Date>[].obs;
  var currentblockedDays = <String>[].obs;
  var nextBlockedDays = <String>[].obs;
  var year = ''.obs;
  var currentMonth = ''.obs;
  var currentMonthDates = [].obs;
  var nextMonth = ''.obs;
  var nextMonthDates = [].obs;
  RxList<String> currentMonthDays = <String>[].obs;
  RxList<String> nextMonthDays = <String>[].obs;

  List<String> getMonthDays(bool isCurrentMonth) {
    List<String> monthDays = [];
    DateTime now = DateTime.now();
    /* DateTime monthStart = isCurrentMonth
        ? DateTime(now.year, now.month, 1)
        : DateTime(now.year, now.month + 1, 1); */
    int daysInMonth =
        DateTime(now.year, now.month + (isCurrentMonth ? 1 : 2), 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      DateTime date =
          DateTime(now.year, now.month + (isCurrentMonth ? 0 : 1), day);
      String dayOfWeek =
          DateFormat.E().format(date); // Get day of the week (e.g., "Mon")

      // Format the date as dd-mm-yyyy
      String formattedDate = DateFormat('yyy-MM-dd').format(date);

      // Add the day of the week and day to the monthDays list
      monthDays.add('$dayOfWeek$day');

      // Add the formatted date to the currentMonthDates list
      if (isCurrentMonth) {
        currentMonthDates.add(formattedDate);
      } else {
        nextMonthDates.add(formattedDate);
      }
    } // Check the populated dates // Check the populated dates
    return monthDays;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    DateTime now = DateTime.now();
    year.value = DateFormat.y().format(DateTime(now.year));
    currentMonth.value = DateFormat.MMMM().format(now);
    nextMonth.value =
        DateFormat.MMMM().format(DateTime(now.year, now.month + 1, 1));
    currentMonthDays.addAll(getMonthDays(true));
    nextMonthDays.addAll(getMonthDays(false));
    await getBlockedDates();
  }

  Future<void> getBlockedDates() async {
    loading.value = true;
    var getBlockedDatesRequest = await WorkingHoursServices.getBlockedDates();
    blockedDates.value = getBlockedDatesRequest!.data!;
    for (var i = 0; i < blockedDates.length; i++) {
      String blockedDate = blockedDates[i].date!;
      if (currentMonthDates.value.contains(blockedDate)) {
        int index = currentMonthDates.value.indexOf(blockedDate);
        currentblockedDays.add(currentMonthDays[index]);
      } else if (nextMonthDates.value.contains(blockedDate)) {
        int index = nextMonthDates.value.indexOf(blockedDate);
        nextBlockedDays.add(nextMonthDays[index]);
      }
    }
    inspect(blockedDates.value);
    loading.value = false;
  }

  Future<BlockedDates?> blockSelectedDates() async {
    blocking.value = true;
    var blockSelectedDatesRequest;
    if (blockedDates.isNotEmpty) {
      blockSelectedDatesRequest =
          await WorkingHoursServices.blockDates(dates: blockedDates);
    } else {
      blockSelectedDatesRequest =
          await WorkingHoursServices.clearblockDates(dates: blockedDates);
    }

    if (blockSelectedDatesRequest != null) {
      toast(message: "Blocked Booking Dates Has been Update".tr);
      Get.back();
    } else {
      toast(message: "Something Went Wrong While trying to block the date".tr);
      Get.back();
    }
    blocking.value = false;
  }

  blockDay(String day, bool iscurrent) {
    if (iscurrent) {
      int index = int.parse(day.substring(3)) - 1;
      blockedDates.add(Date(
          date: currentMonthDates[index],
          day: day.substring(0, 3).toUpperCase()));
      currentblockedDays.add(day);
    } else {
      int index = int.parse(day.substring(3)) - 1;
      blockedDates.add(Date(
          date: nextMonthDates[index], day: day.substring(0, 3).toUpperCase()));
      nextBlockedDays.add(day);
    }
  }

  void unBlockDay(String day, bool iscurrent) {
    int index =
        int.parse(day.substring(3)) - 1; // Get the index from the day string

    if (iscurrent) {
      // For current month, find the corresponding index
      Date dateToRemove = Date(
        date: currentMonthDates[index],
        day: day.substring(0, 3).toUpperCase(),
      );

      // Find the index of the dateToRemove in blockedDates
      int removeIndex =
          blockedDates.indexWhere((d) => d.date == dateToRemove.date);

      // Remove the item at that index if it exists
      if (removeIndex != -1) {
        blockedDates.removeAt(removeIndex);
      }

      currentblockedDays.remove(day);
    } else {
      // For next month, find the corresponding index
      Date dateToRemove = Date(
        date: nextMonthDates[index],
        day: day.substring(0, 3).toUpperCase(),
      );

      // Find the index of the dateToRemove in blockedDates
      int removeIndex =
          blockedDates.indexWhere((d) => d.date == dateToRemove.date);

      // Remove the item at that index if it exists
      if (removeIndex != -1) {
        blockedDates.removeAt(removeIndex);
      }

      nextBlockedDays.remove(day);
    }
  }
}
