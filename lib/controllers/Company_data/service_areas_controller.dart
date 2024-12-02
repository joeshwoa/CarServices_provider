import 'dart:convert';
import 'dart:developer';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/models/work%20areas/areas.dart';
import 'package:autoflex/models/work%20areas/work_areas.dart';
import 'package:autoflex/services/company/workareas_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceAreasController extends GetxController {
  final CompanyDetailsController companyDetailsController =
      Get.find<CompanyDetailsController>();
  var serviceAreasFormKeys =
      List.generate(7, (index) => GlobalKey<FormState>());
  var loading = false.obs;
  var selectedAreas = <Datum>[].obs;
  var selectedEmirates = [].obs;
  List<bool> isExpanded = List.generate(7, (_) => false).obs;
  List<bool> isSwitched = List.generate(7, (_) => false).obs;
  List<bool> isEmriteChecked = List.generate(7, (_) => false).obs;
  var emrites = [].obs;
  RxList<List<bool>> isCityChecked = <List<bool>>[].obs;

  RxList<List<TextEditingController>> controllers =
      <List<TextEditingController>>[].obs;

  @override
  void onInit() async {
    super.onInit();

    // Use await to fetch emirate areas
    emrites.value = [
      {'id': 1, "name": 'Abu Dhabi'.tr, 'cities': await getEmirateAreas(1)},
      {'id': 2, "name": 'Dubai'.tr, 'cities': await getEmirateAreas(2)},
      {'id': 3, "name": 'Sharjah'.tr, 'cities': await getEmirateAreas(3)},
      {'id': 4, "name": 'Ajman'.tr, 'cities': await getEmirateAreas(4)},
      {'id': 5, "name": 'Umm Al Quwain'.tr, 'cities': await getEmirateAreas(5)},
      {
        'id': 6,
        "name": 'Ras Al Khaimah'.tr,
        'cities': await getEmirateAreas(6)
      },
      {'id': 7, "name": 'Fujairah'.tr, 'cities': await getEmirateAreas(7)},
    ];

    isCityChecked.value = emrites
        .map((emrite) =>
            List.generate(emrite['cities'].length, (index) => false))
        .toList();

    controllers.value = emrites
        .map((emrite) => List.generate(
            emrite['cities'].length, (index) => TextEditingController()))
        .toList();

    await getWorkinAreas();
  }

  checkCity(index, j) {
    loading.value = true;
    // Create a copy of the current isCityChecked list
    var updatedList = isCityChecked[index].toList();

    // Update the copy
    updatedList[j] = !updatedList[j];

    // Assign the updated copy back to isCityChecked
    isCityChecked[index] = updatedList;
    addServiceAreas(index);
    loading.value = false;
  }

  checkValidation(index) {
    final isValid = serviceAreasFormKeys[index].currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  addServiceAreas(index) {
    if (checkValidation(index)) {
      selectedAreas.clear();
      selectedEmirates.clear();

      for (var i = 0; i < isCityChecked.length; i++) {
        bool emirateAdded = false;
        for (var j = 0; j < isCityChecked[i].length; j++) {
          if (isCityChecked[i][j]) {
            var city = emrites[i]['cities'][j] as Area;
            selectedAreas.add(Datum(
                cityId: city.id,
                emirateId: emrites[i]['id'],
                reachTime: controllers[i][j].text));
            if (!emirateAdded) {
              var emirate = emrites[i]['name'];
              selectedEmirates.add(emirate);
              emirateAdded = true;
            }
          }
        }
      }
      inspect(selectedAreas.value);
      inspect(selectedEmirates.value);
    }
  }

  getEmirateAreas(emirateId) async {
    loading.value = true;
    var getEmirateAreaRequest = await WorkingAreasServices.getAreas(emirateId);
    if (getEmirateAreaRequest != null) {
      loading.value = false;
      return getEmirateAreaRequest.data!;
    } else {
      toast(
          message:
              '${'Could not Fetch Areas For'.tr} ${emrites[emirateId - 1]['name']} Emirate');
      loading.value = false;
      return [];
    }
  }

  getWorkinAreas() async {
    loading.value = true;
    var getWorkinAreasRequest = await WorkingAreasServices.getWorkAreas();
    if (getWorkinAreasRequest != null) {
      loading.value = false;
      selectedAreas.value = getWorkinAreasRequest.data!;
      for (var area in selectedAreas) {
        var allAreas = true;
        var emirate = emrites[area.emirateId! - 1];
        isEmriteChecked[area.emirateId! - 1] = true;
        for (int i = 0; i < emirate['cities'].length; i++) {
          if (emirate['cities'][i].id == area.cityId) {
            isCityChecked[area.emirateId! - 1][i] = true;
            controllers[area.emirateId! - 1][i].text = area.reachTime ?? '';
          }
        }
        for (int j = 0; j < emirate['cities'].length; j++) {
          if (isCityChecked[area.emirateId! - 1][j] != true) {
            allAreas = false;
          }
        }
        isSwitched[area.emirateId! - 1] = allAreas;
      }
    } else {
      toast(message: 'Failed to Fetch Working Areas'.tr);
      loading.value = false;
      return [];
    }
  }

  /* updateServiceAreas() async {
    loading.value = true;
    var updateServiceAreasRequest =
        await WorkingAreasServices.updateAreas(areas: selectedAreas);
    if (updateServiceAreasRequest != null) {
      toast(message: 'Service Areas Has Been Updated');
      Get.back();
    } else {
      toast(message: 'Changes Could not Be Saved');
    }
    loading.value = false;
  } */

  Future<void> updateServiceAreas() async {
    loading.value = true;
    var stop = false;
    var emirate = '';
    for (int i = 0; i < isEmriteChecked.length; i++) {
      if (isEmriteChecked[i]) {
        if (!checkValidation(i)) {
          stop = true;
          emirate = emrites[i]['name'];
          break;
        }
      }
    }
    if (!stop) {
      var updateServiceAreasRequest =
          await WorkingAreasServices.updateAreas(areas: selectedAreas);
      if (updateServiceAreasRequest != null) {
        toast(message: 'Service Areas Has Been Updated'.tr);
        Get.back();
      } else {
        toast(message: 'Changes Could not Be Saved'.tr);
      }
    } else {
      Get.snackbar("Missing Inputs".tr, "${'Please Add missing inputs in'.tr} $emirate",
          backgroundColor: ConstantColors.errorColor, colorText: Colors.white);
    }
    loading.value = false;
  }
}
