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
import 'package:autoflex/controllers/Home/worker/workerHome-controller.dart';
import 'package:autoflex/controllers/worker/worker_menu_controller.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Company_data/bank/manage_bank_accounts.dart';
import 'package:autoflex/views/Company_data/bussines%20hours/manage_hours.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Company_data/manage%20workers/manage_workers.dart';
import 'package:autoflex/views/Company_data/services/manageServices.dart';
import 'package:autoflex/views/Company_data/service_areas.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:autoflex/views/Home/provider/manageJobs.dart';
import 'package:autoflex/views/Home/worker/workerMenu.dart';
import 'package:autoflex/views/faqs_screen.dart';
import 'package:autoflex/views/talk_to_us_screen.dart';
import 'package:autoflex/views/terms_and_conditions_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restart_app/restart_app.dart';

import '../../../main.dart';
import '../../../shared/components/loading.dart';
import '../../../shared/components/menuOptions.dart';
import '../../../shared/styles/icons_assets.dart';

List<List<dynamic>> personalOptions = [
  // ['Personal/Account Details'.tr, id],
  ['Company Details'.tr, star_gray, CompanyDetailsScreen()]
];
List<List<dynamic>> companyOptions = [
  ['Manage Services '.tr, worker_engin_gray, ManageServicesScreen()],
  ['Manage Business Hours & Days'.tr, calendar_clock_gray, ManageHoursScreen()],
  ['Manage Service Areas'.tr, location_on_gray, ServiceAreasScreen()],
  ['Manage Workers'.tr, account_circle_gray, ManageWorkersScreen()],
  ['Manage Bank Details '.tr, account_balance_gray, ManageBankAccountsScreen()]
];
List<List<dynamic>> appOptions = [
  // ['Account Settings'.tr, settings],
  ['Terms & Conditions'.tr, article, const TermsScreen()]
];
List<List<dynamic>> supportOptions = [
  ['Talk to Us'.tr, headset, TalkToUsScreen()],
  ['FAQs'.tr, faq, const FAQsScreen()]
];

class MenuScreen extends StatelessWidget {
  MenuScreen({super.key});
  // final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final CompanyDetailsController controller =Get.put(CompanyDetailsController());
     final AddCompanyDataController addCompanyController =Get.put(AddCompanyDataController());
    return Obx(()=>
     Stack(
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
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () async {
                             if( sharedPreferenceController
                            .localization
                            .value=='en')
                        { Get.updateLocale(
                            Locale('ar'));
                        sharedPreferenceController
                            .localization
                            .value = 'ar';
                        await sharedPreferenceController
                            .setValue('localization',
                            'ar');}
                        else{
                          Get.updateLocale(
                              Locale('en'));
                          sharedPreferenceController
                              .localization
                              .value = 'en';
                          await sharedPreferenceController
                              .setValue('localization',
                              'en');
                        }

                        await Restart.restartApp();
                          },
                          child: Text(
                            'العربية'.tr,
                            style: TextStyle(
                                fontSize: 11,
                                color: ConstantColors.primaryColor,
                                fontFamily: localization == "en"
                                    ? GoogleFonts.roboto().fontFamily
                                    : 'DubaiFont',
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        SvgPicture.asset(language),
                      ],
                    ),
                  )
                ],
              ),
              body: SingleChildScrollView(
                  child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                                child:controller.company.value.logo!=null?CachedNetworkImage(
                                              imageUrl: controller.company.value.logo!,
                                              width: 100,
                                              height: 100,
                                              placeholder: (context, url) =>
                                                  CircularProgressIndicator(),
                                              errorWidget: (context, url, error) =>
                                                  const Icon(Icons.error,
                                                      color: Color.fromARGB(
                                                          255, 17, 14, 14)),
                                            ):SizedBox(),),
                            Text(controller.company.value.name ?? '',
                                style: Theme.of(context).textTheme.titleSmall),
                            SizedBox(
                              height: 36,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () => {
                                    Get.to(()=>ManageJobsScreen())
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: ConstantColors.primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(list_blue),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              width: 87,
                                              child: Text('Manage Orders'.tr,
                                                  style: TextStyle(
                                                      overflow: TextOverflow.visible,
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontFamily: GoogleFonts.roboto()
                                                          .fontFamily,
                                                      fontWeight: FontWeight.w700)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Get.locale?.languageCode == 'en'
                                            ? SvgPicture.asset(
                                          navigateNext,)
                                            : Transform.rotate(
                                          angle: 3.14,
                                          child: SvgPicture.asset(
                                            navigateNext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                InkWell(
                                    onTap: () => {
                                    Get.to(()=>HomeScreen())
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: ConstantColors.primaryColor,
                                        borderRadius: BorderRadius.circular(8)),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SvgPicture.asset(wallet),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            Container(
                                              width: 87,
                                              child: Text('Manage Earnings'.tr,
                                                  style: TextStyle(
                                                      overflow: TextOverflow.visible,
                                                      fontSize: 13,
                                                      color: Colors.white,
                                                      fontFamily: GoogleFonts.roboto()
                                                          .fontFamily,
                                                      fontWeight: FontWeight.w700)),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        Get.locale?.languageCode == 'en'
                                            ? SvgPicture.asset(
                                          navigateNext,)
                                            : Transform.rotate(
                                          angle: 3.14,
                                          child: SvgPicture.asset(
                                            navigateNext,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: List.generate(
                                  personalOptions.length,
                                  (index) => MenuOption(
                                      label: personalOptions[index][0],
                                      icon: personalOptions[index][1],
                                      onPressed: () {
                                        if (personalOptions[index][2] != null) {
                                          Get.to(() =>
                                              personalOptions[index][2] as Widget);
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
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: List.generate(
                                  companyOptions.length,
                                  (index) => MenuOption(
                                      label: companyOptions[index][0],
                                      icon: companyOptions[index][1],
                                      onPressed: () {
                                        if (companyOptions[index][2] != null) {
                                          Get.to(() =>
                                              companyOptions[index][2] as Widget);
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
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: List.generate(
                                  appOptions.length,
                                  (index) => MenuOption(
                                      label: appOptions[index][0],
                                      icon: appOptions[index][1],
                                      onPressed: () {
                                        if (appOptions[index][2] != null) {
                                          Get.to(
                                              () => appOptions[index][2] as Widget);
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
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: Column(
                                children: List.generate(
                                  supportOptions.length,
                                  (index) => MenuOption(
                                      label: supportOptions[index][0],
                                      icon: supportOptions[index][1],
                                      onPressed: () {
                                        if (supportOptions[index][2] != null) {
                                          Get.to(() =>
                                              supportOptions[index][2] as Widget);
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
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              foregroundDecoration: BoxDecoration(
                                border: Border.all(color: ConstantColors.borderColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 60,
                                child: FractionallySizedBox(
                                  widthFactor: 1,
                                  child: OutlinedButton.icon(
                                        onPressed: () async {
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .isLoggedIn
                                  .value = false;

                              await Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .setBoolValue("isLoggedIn", false);
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .removeValue();

                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .isLoggedIn
                                  .refresh();
                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .userToken
                                  .value = '';

                              Get.find<SharedPreferenceController>(
                                      tag: 'tagsAreEverywhere')
                                  .update();

                              Future.delayed(const Duration(seconds: 0),
                                  () async {
                                logoutController.logoutRequest();
                                Get.delete<HomeController>(force: true);
                           Get.delete<ServiceAreasController>(force: true);
                           Get.delete<ManageHoursController>(force: true);
                           Get.delete<CompanyDetailsController>(force: true);
                           Get.delete<AddCompanyDataController>(force: true);
                           Get.delete<BankingController>(force: true);
                           Get.delete<WorkerMenuController>(force: true);
                           Get.delete<WorkerHomeController>(force: true);
                           Get.delete<WorkerController>(force: true);
                           Get.delete<HomeController>(force: true);
                       Get.delete<BlockDaysController>(force: true);
                       Get.delete<EditBankingController>(force: true);
                       Get.delete<CompanyWorkersDetailsController>(force: true);
                       Get.delete<EditCompanyWorkersController>(force: true);
                       Get.delete<ServicesController>(force: true);
                       Get.delete<SubCategoryController>(force: true);
                       Get.delete<HomeController>(force: true);
                                Get.offAll(() => SignInScreen());
                              });
                            },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(Colors.white),
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
                                          color: ConstantColors.bodyColor,)
                                            : Transform.rotate(
                                          angle: 3.14,
                                          child: SvgPicture.asset(
                                            navigateNext,
                                            color: ConstantColors.bodyColor,
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
      ),
    );
  }
}
