import 'dart:developer';

import 'package:autoflex/controllers/Auth/success-screen.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/models/company.dart';
import 'package:autoflex/services/company/company_services.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddCompanyDataController extends GetxController {
  final companyController = Get.put(CompanyDetailsController());
  var company = Data().obs;

  late GlobalKey<FormState> AddCompanyDataFormKey;
  Rx<XFile?> companyImage = XFile("").obs;
  Rx<XFile?> licenceImage = XFile("").obs;
  Rx<XFile?> passportImage = XFile("").obs;
  Rx<XFile?> idImage = XFile("").obs;
  TextEditingController companyNameController = TextEditingController();
  TextEditingController companyPhoneController = TextEditingController();
  TextEditingController companyAddressController = TextEditingController();
  TextEditingController licenceController = TextEditingController();
  TextEditingController passportController = TextEditingController();
  TextEditingController idController = TextEditingController();
  var imageUploaded = false.obs;
  var loading = false.obs;
  var imageMessage = ''.obs;
  var errorMessage = ''.obs;
  var isPlaceholderVisible = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    AddCompanyDataFormKey = GlobalKey<FormState>();
    await getCompanyDetails();
    // if (Get.arguments != null) {
    //   inspect('HELLO????');
    //   if (Get.arguments['type'] == 'edit') {
    //     inspect(company.value.name);
    //     companyNameController.text = company.value.name ?? '';
    //     companyPhoneController.text = company.value.phone ?? '';
    //     companyAddressController.text = company.value.address ?? '';
    //   }
    // }
  }

  void resetKey() {
    AddCompanyDataFormKey = GlobalKey<FormState>();
  }

  addImage(type) async {
    if (type == 'licence') {
      licenceImage.value = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (kDebugMode) {
        print(licenceImage.value!.path);
      }
// licenceController.text=licenceImage.value!.path;
    } else if (type == 'passport') {
      passportImage.value = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );

      // passportController.text=passportImage.value!.path;
    } else {
      idImage.value = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      inspect('asdasdsdasdasd');
      // idController.text=idImage.value!.path;
    }
  }

  changePhotoRequest(type) async {
    try {
      if (type == 'gallery') {
        companyImage.value = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      } else {
        companyImage.value = await ImagePicker().pickImage(
          source: ImageSource.camera,
          maxWidth: 1800,
          maxHeight: 1800,
        );
      }
      imageUploaded.value = true;
      if (kDebugMode) {
        print(companyImage.value?.path);
      }
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
    }
  }

  checkValidation(type) {
    final isValid = AddCompanyDataFormKey.currentState!.validate();
    if (!imageUploaded.value && type == add) {
      imageMessage.value = 'Logo must not be empty'.tr;
    }
    if (passportImage.value?.path == '' && type == add ||
        companyImage.value?.path == '' && type == add ||
        licenceImage.value?.path == '' && type == add) {
      errorMessage.value =
          'Trade License ,passport copy and owner emirates id must not be empty'
              .tr;
    }
    if (!isValid || imageMessage.value != '' || errorMessage.value != '') {
      return false;
    } else {
      imageMessage.value = '';
      return true;
    }
  }

  getCompanyDetails() async {
    loading.value = true;
    Company? companyRequest = await CompanyServices.getCompany();
    if (companyRequest != null && (companyRequest.data != null)) {
      company.value = companyRequest.data!;
      if (Get.arguments != null) {
        if (Get.arguments['type'] == 'edit') {
          inspect(company.value.name);
          companyNameController.text = company.value.name ?? '';
          companyPhoneController.text = company.value.phone ?? '';
          companyAddressController.text = company.value.address ?? '';
        }
      }
    }
    if (company.value.phone == null) {
      toast(message: 'Could not Find Company Information'.tr);
    }
    loading.value = false;
  }

  addCompanyDetails(
      {required String logo,
      required String name,
      required String phone,
      required String address,
      required String license,
      required String passport,
      required String idCard}) async {
    if (checkValidation(add)) {
      loading.value = true;
      Company? addCompanyDetailsRequest = await CompanyServices.addCompany(
        name: name,
        phone: phone,
        address: address,
        license: license,
        logo: logo,
        passport: passport,
        idCard: idCard,
      );
      toast(message: addCompanyDetailsRequest!.message!);
      imageMessage.value = '';
      errorMessage.value = '';
      inspect(addCompanyDetailsRequest.data);
      Future.delayed(const Duration(seconds: 2),
          await companyController.getCompanyDetails());
      await companyController.getMeData();
      // Get.to(() => CompanyDetailsScreen());
      Get.to(() => SucessScreen(), arguments: {'type': 'companyAdded'});
      loading.value = false;
    }
  }

  updateCompanyDetails(
      {required String logo,
      required String name,
      required String phone,
      required String address,
      required String license,
      required String passport,
      required String idCard}) async {
    if (checkValidation(edit)) {
      loading.value = true;
      Company? updateCompanyDetailsRequest;
      updateCompanyDetailsRequest = await CompanyServices.updateCompany(
        name: name,
        phone: phone,
        address: address,
        license: license,
        logo: logo,
        passport: passport,
        idCard: idCard,
      );
      toast(message: updateCompanyDetailsRequest!.message!);
      Future.delayed(
        const Duration(seconds: 2),
        await companyController.getCompanyDetails(),
      );
      await companyController.getMeData();
      Get.back();

      loading.value = false;
    }
  }
}
