import 'package:autoflex/controllers/Auth/logout.dart';
import 'package:autoflex/controllers/Company_data/addCompanyData-controller.dart';
import 'package:autoflex/controllers/Company_data/banking/banking_controller.dart';
import 'package:autoflex/controllers/Company_data/banking/edit_bank_account_controller.dart';
import 'package:autoflex/controllers/Company_data/bussines%20hours/block_days_controller.dart';
import 'package:autoflex/controllers/Company_data/bussines%20hours/manage_hours_controller.dart';
import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/company%20workers/edit_company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/controllers/Company_data/service_areas_controller.dart';
import 'package:autoflex/controllers/Company_data/services/services_controller.dart';
import 'package:autoflex/controllers/Company_data/services/subcategory_controller.dart';
import 'package:autoflex/controllers/Company_data/worker_controller.dart';
import 'package:autoflex/controllers/Home/home-controller.dart';
import 'package:autoflex/controllers/Home/worker/workerData-controller.dart';
import 'package:autoflex/controllers/Home/worker/workerHome-controller.dart';
import 'package:autoflex/controllers/worker/worker_menu_controller.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Company_data/bank/manage_bank_accounts.dart';
import 'package:autoflex/views/Company_data/bussines%20hours/manage_hours.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';
import 'package:autoflex/views/Company_data/services/manageServices.dart';
import 'package:autoflex/views/Company_data/service_areas.dart';
import 'package:autoflex/views/Home/worker/pastJobs.dart';
import 'package:autoflex/views/Home/worker/worker-home.dart';
import 'package:autoflex/views/Home/worker/workerData.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../../../main.dart';
import '../../../shared/components/menuOptions.dart';
import '../../../shared/styles/icons_assets.dart';

List<List<dynamic>> Options = [
  ['Account Details'.tr, id, WorkerDataScreen()],
  ['Today’s Jobs'.tr, location_on_gray, WorkerHomeScreen()],
  ['Future Jobs'.tr, car, WorkerHomeScreen()],
  ['Past Jobs'.tr, shopping_cart_checkout, PastJobsScreen()],
];
LogoutController logoutController = Get.put(LogoutController());

class WorkerMenuScreen extends StatelessWidget {
  WorkerMenuScreen({super.key});
  final WorkerMenuController controller = Get.put(WorkerMenuController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Stack(
        children: [
          Scaffold(
              backgroundColor: ConstantColors.backgroundColor,
              appBar: AppBar(
                elevation: 0.0,
                backgroundColor: ConstantColors.backgroundColor,
                centerTitle: true,
                leading: IconButton(
                  icon: Get.locale?.languageCode == 'en'
                      ? SvgPicture.asset(arrowBack)
                      : Transform.rotate(
                          angle: 3.14,
                          child: SvgPicture.asset(arrowBack),
                        ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: InkWell(
                      onTap: () async {
                        if (sharedPreferenceController.localization.value ==
                            'en') {
                          Get.updateLocale(Locale('ar'));
                          sharedPreferenceController.localization.value = 'ar';
                          await sharedPreferenceController.setValue(
                              'localization', 'ar');
                        } else {
                          Get.updateLocale(Locale('en'));
                          sharedPreferenceController.localization.value = 'en';
                          await sharedPreferenceController.setValue(
                              'localization', 'en');
                        }

                        await Restart.restartApp();
                      },
                      child: Row(
                        children: [
                          Text(
                            'العربية'.tr,
                            style: TextStyle(
                                fontSize: 11,
                                color: ConstantColors.primaryColor,
                                fontFamily: localization == "en"
                                    ? GoogleFonts.roboto().fontFamily
                                    : 'DubaiFont',
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          SvgPicture.asset(language),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child:
                                  controller.workerDetails.value.data!.image !=
                                          null
                                      ? CachedNetworkImage(
                                          imageUrl: controller
                                              .workerDetails.value.data!.image!,
                                          width: 100,
                                          height: 100,
                                          placeholder: (context, url) =>
                                              CircularProgressIndicator(),
                                          errorWidget: (context, url, error) =>
                                              const Icon(Icons.error,
                                                  color: Color.fromARGB(
                                                      255, 17, 14, 14)),
                                        )
                                      : SizedBox(),
                            ),
                            Text(
                                controller.workerDetails.value.data!.fullName ??
                                    '',
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(
                              height: 36,
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(
                                    color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: List.generate(
                                  Options.length,
                                  (index) => MenuOption(
                                      label: Options[index][0],
                                      icon: Options[index][1],
                                      onPressed: () {
                                        if (Options[index][2] != null) {
                                          if (index == 2) {
                                            Get.find<WorkerHomeController>()
                                                .selectedTab
                                                .value = 'Future Jobs'.tr;
                                            Get.find<WorkerHomeController>()
                                                .getOrders();
                                          }
                                          Get.to(() =>
                                              Options[index][2] as Widget);
                                        }
                                      }),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                    color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(
                                    color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 60,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton.icon(
                                    onPressed: () async {
                                      //         Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .isLoggedIn
                                      //             .value = false;

                                      //         await Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .setBoolValue("isLoggedIn", false);
                                      //         Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .removeValue();

                                      //         Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .isLoggedIn
                                      //             .refresh();
                                      //         Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .userToken
                                      //             .value = '';

                                      //         Get.find<SharedPreferenceController>(
                                      //                 tag: 'tagsAreEverywhere')
                                      //             .update();

                                      Future.delayed(const Duration(seconds: 0),
                                          () async {
                                        await controller.logoutRequest();
                                        Get.delete<WorkerHomeController>(
                                            force: true);
                                        Get.delete<WorkerDataController>(
                                            force: true);
                                        Get.delete<WorkerMenuController>(
                                            force: true);
                                        Get.offAll(() => SignInScreen());
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.white),
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero)),
                                    ),
                                    icon: SvgPicture.asset(logout),
                                    label: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        SizedBox(
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                  width:
                                                      8), // Adjust the width for desired space between icon and label
                                              Text(
                                                'Logout'.tr,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyLarge!
                                                    .copyWith(
                                                        color: ConstantColors
                                                            .secondaryColor),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Get.locale?.languageCode == 'en'
                                            ? SvgPicture.asset(
                                                navigateNext,
                                                color: ConstantColors.bodyColor,
                                              )
                                            : Transform.rotate(
                                                angle: 3.14,
                                                child: SvgPicture.asset(
                                                  navigateNext,
                                                  color:
                                                      ConstantColors.bodyColor,
                                                ),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ])))),
          controller.loading.value ? const LoadingWidget() : Row()
        ],
      );
    });
  }
}
