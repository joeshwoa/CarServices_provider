import 'dart:developer';

import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/models/login.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/constants.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Company_data/bank/manage_bank_accounts.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';

import 'package:autoflex/views/Company_data/addCompanyData.dart';
import 'package:autoflex/views/Home/worker/worker-home.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../views/Home/provider/home.dart';
import 'package:http/http.dart' as http;

  final CompanyDetailsController companyDetailsController = Get.put(
        CompanyDetailsController());
class SignInController extends GetxController {
  final signInFormKey = GlobalKey<FormState>();
  // GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  var type = "password".obs;
  var visiblePassword = false.obs;
  var loading = false.obs;
  var errorMessage = "".obs;
  var roles = ['Business Owner'.tr, 'Worker'.tr].obs;
  var selectedRole = ''.obs;
  var isExpanded = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  void onInit() {
    super.onInit();
    selectedRole.value = roles[0];
  }

  selectRole(role) {
    selectedRole.value = role;
    isExpanded.value = false;
  }

  checkValidation() {
    final isValid = signInFormKey.currentState!.validate();
    if (!isValid) {
      return false;
    } else {
      return true;
    }
  }

  Future<String?> loginRequest() async {
    if (checkValidation()) {
      try {
        loading.value = true;

        Login? signInRequest = await AuthService.sigIn(
            email: emailController.text,
            password: passwordController.text,
            role: selectedRole.value);
        // return '';
        //not valid in arabic
        if (signInRequest!.message == 'Logged in successfully.' ||
            signInRequest!.message!.contains('بنجاح')) {
          errorMessage.value = "";

          toast(message: signInRequest.message.toString());

          await sharedPreferenceController.setValue(
              'userData', loginToJson(signInRequest));
          sharedPreferenceController.update();

          sharedPreferenceController.userToken.value =
              signInRequest.token.toString();
          sharedPreferenceController.userToken.refresh();
          Constants.headersWithToken.update(
              'Authorization',
              (value) =>
                  'Bearer ${Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere').userToken.value}');

          sharedPreferenceController.isLoggedIn.value = true;
          sharedPreferenceController.welcomed.value = true;
          sharedPreferenceController.isLoggedIn.refresh();
          sharedPreferenceController.userData.value = signInRequest;
          sharedPreferenceController.userData.refresh();
          await sharedPreferenceController.setBoolValue("isLoggedIn", true);
          await sharedPreferenceController.setBoolValue("welcomed", true);
          await sharedPreferenceController.setValue(
              "token", signInRequest.token);
          sharedPreferenceController.userType.value = selectedRole.value;
          await sharedPreferenceController.setValue(
              "userType", selectedRole.value);
          inspect(signInRequest.token);

          if(selectedRole.value == 'Worker'.tr) {
            var response =
            await http.get(Uri.parse('https://autoflex.innovationbox.ae/api/v1/worker/orders?future=${ DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}'), headers: {
              'Accept': 'application/json',
              'Content-type': 'application/json',
              'Authorization':
              'Bearer ${signInRequest.token}',
              'iso': sharedPreferenceController.localization.value
            });
            if (response.statusCode == 200 || response.statusCode == 201) {
              await sharedPreferenceController.setValue('WorkerOrders', response.body);
            }
          }

          //  await sharedPreferenceController.setValue(
          // "userData", signUpToJson(signInRequest));
          sharedPreferenceController.update();
          print(signInRequest.token);
          Future.delayed(const Duration(seconds: 2), () {
            loading.value = false;
            if(selectedRole.value == 'Worker'.tr)
             { Get.offAll(() => WorkerHomeScreen());}
              else{
                if(sharedPreferenceController.userData.value.data!.hasCompany!)
                { if(sharedPreferenceController.userData.value.data!.isCompleted!)
                  {Get.offAll(() => HomeScreen(),arguments: {'screen': 'login'});}
                  else{
                    Get.offAll(() => CompanyDetailsScreen());
                  }
                  } 
                else{ Get.offAll(() => AddCompanyDataScreen()
                ,arguments: {'type': 'add'} );}
            }  });
          return "registered successfully";
        } else {
          errorMessage.value = signInRequest.message!.split('.')[0];
          loading.value = false;
          return signInRequest.message;
        }
        // }
      } catch (e) {
        if (kDebugMode) {
          loading.value = false;
          print(e);
        }
      }
    }
  }

  /* Future<String?> loginRequest() async {
    if (checkValidation()) {
      try {
        selectedRole.value=='Worker'
        ?Get.to(()=>WorkerHomeScreen())
        :Get.to(()=>AddCompanyDataScreen(),arguments: {'screen':'login'});


      }catch(e){print(e);}
  }
  
  } */
}
