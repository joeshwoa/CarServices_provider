import 'dart:developer';
import 'dart:ffi';

import 'package:autoflex/models/bank/bank_accounts.dart';
import 'package:autoflex/models/bussiness%20hours/blockedDates.dart';
import 'package:autoflex/models/company%20workers/company_workers.dart';
import 'package:autoflex/models/login.dart';

import 'package:autoflex/models/products/company_products.dart';
import 'package:autoflex/models/work%20areas/service_areas.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/services/company/banking_services.dart';
import 'package:autoflex/services/company/company_workers_services.dart';
import 'package:autoflex/services/company/workareas_services.dart';
import 'package:autoflex/services/company/working_hours_services.dart';
import 'package:autoflex/services/products/productsServices.dart';
import 'package:autoflex/shared/components/toast.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:get/get.dart';
import 'package:autoflex/models/company.dart' as Company;
import 'package:intl/intl.dart';
import '../../services/company/company_services.dart';

class CompanyDetailsController extends GetxController {
  var workingHours = [].obs;
  var loading = false.obs;
  var servicesAreas = <Emirate>[].obs;
  var workers = <String>[].obs;
  var bankAccounts = <String>[].obs;
  var company =  Company.Data().obs;
  var services = <Item>[].obs;
  var blockedDates = <String>[].obs;
  var hasCompany=false.obs;
  var isCompleted=false.obs;
  var weekcodes = {
    "MON": 'Monday'.tr,
    "TUE": 'Tuesday'.tr,
    "WED": 'Wednesday'.tr,
    "THU": 'Thursday'.tr,
    "FRI": 'Friday'.tr,
    "SAT": 'Saturday'.tr,
    "SUN": 'Sunday'.tr
  };

  var emrites = [
    {'id': 1, "name": 'Abu Dhabi'.tr},
    {'id': 2, "name": 'Dubai'.tr},
    {'id': 3, "name": 'Sharjah'.tr},
    {'id': 4, "name": 'Ajman'.tr},
    {'id': 5, "name": 'Umm Al Quwain'.tr},
    {'id': 6, "name": 'Ras Al Khaimah'.tr},
    {'id': 7, "name": 'Fujairah'.tr},
  ].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await getMeData();
    if(sharedPreferenceController.userData.value.data!.hasCompany??false)
 {  
await getCompanyDetails();
    await getCompanyServices();
    await getBlockedDates();
    await getWorkingHours();
    await getServiceAreas();
    await getCompanyWorkers();
    await getBankAccounts();
    }

    /*
    servicesAreas.value = {
      'city': 'Sharjah',
      'areas': [
        'Almajaz 1',
        ' Almajaz 2',
        'Almajaz 3',
        'Rolla',
        'Al Qasmia',
        'Industrial Area 1',
        'Industrial Area 2',
        'Industrial Area 3',
        'Industrial Area 4',
        'Industrial Area 5'
      ]
    } as List;
    workers.value = ['Irshad Abas', 'Laylod Michel', 'Rustam Raj'];
    bankAccounts.value = ['Emirtes NBD', 'Mashriq NEO'];
    services.value = [
      'Foam Wash',
      'Detailed Wash',
      'Disinfection',
      'Detailing'
    ];
    blockedDates.value = ['Jan 21 2024', 'Jan 29 2024', 'Feb 13 2024']; */
  }
getMeData() async {
    loading.value = true;
    Login? meDataRequest = await AuthService.meData();
    if (meDataRequest != null && (meDataRequest.data != null)) {
      hasCompany.value = meDataRequest.data!.hasCompany!;
isCompleted.value=meDataRequest.data!.isCompleted!;
sharedPreferenceController.userData.value.data!.hasCompany= meDataRequest.data!.hasCompany!;
sharedPreferenceController.userData.value.data!.isCompleted= meDataRequest.data!.isCompleted!;
sharedPreferenceController.userData.value.data!.isApproved=meDataRequest.data!.isApproved!;
print(sharedPreferenceController.userData.value.data!.hasCompany);
    }
print(hasCompany.value);
print(isCompleted.value);
    loading.value = false;

  }
  getCompanyDetails() async {
    loading.value = true;
    Company.Company? companyRequest = await CompanyServices.getCompany();
    if (companyRequest != null && (companyRequest.data != null)) {
      company.value = companyRequest.data!;
    }
    if (company.value.phone == null) {
      toast(message: 'Could not Find Company Information'.tr);
    }
    loading.value = false;
    print('company cont');
    inspect(company);
  }

  getServiceAreas() async {
    loading.value = true;
    var getServiceAreasRequest = await WorkingAreasServices.getWorkAreasInfo();
    if (getServiceAreasRequest != null) {
      servicesAreas.value = getServiceAreasRequest!.data!;
    } else {
      toast(message: 'Could not Find Service Areas'.tr);
    }
    loading.value = false;
  }

  getCompanyWorkers() async {
    loading.value = true;
    workers.clear();
    List<CompanyWorker> companyWorkers;
    var getCompanyWorkersRequest =
        await CompanyWorkersServices.getCompanyWorkers();
    if (getCompanyWorkersRequest != null) {
      companyWorkers = getCompanyWorkersRequest!.data!;
      if (getCompanyWorkersRequest != null) {
        companyWorkers = getCompanyWorkersRequest!.data!;
        workers.addAll(companyWorkers
            .map((companyWorker) => companyWorker.fullName ?? ""));
      }
    } else {
      toast(message: 'Could not Find Service Areas'.tr);
    }
    loading.value = false;
  }

  getBankAccounts() async {
    loading.value = true;
    bankAccounts.clear();
    var getBankAccountsRequest = await BankingServices.getAccounts();
    List<Datum> accounts;
    if (getBankAccountsRequest != null) {
      accounts = getBankAccountsRequest!.data!;
      if (getBankAccountsRequest != null) {
        accounts = getBankAccountsRequest!.data!;
        bankAccounts.addAll(accounts.map((account) => account.bankName ?? ""));
      }
    } else {
      toast(message: 'Could not Find Bank Accounts'.tr);
    }
    loading.value = false;
    inspect(bankAccounts.value);
  }

  getCompanyServices() async {
    loading.value = true;
    var getServicesRequest = await ProductsServices.getServices();
    services.value = getServicesRequest!.data!;
    inspect(services.value);
    loading.value = false;
  }

  getBlockedDates() async {
    loading.value = true;
    var getBlockedDatesRequest = await WorkingHoursServices.getBlockedDates();
    // Create a DateFormat object for the desired format
    final DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    final DateFormat outputFormat = DateFormat('MMM dd yyyy');
    var rawDates = getBlockedDatesRequest!.data!;
    // Convert and format dates
    blockedDates.value = rawDates.map((e) {
      DateTime date = inputFormat.parse(e.date!); // Parse the input date
      return outputFormat.format(date); // Format the date to the desired format
    }).toList();
    inspect(blockedDates.value);
    loading.value = false;
  }

  getWorkingHours() async {
    loading.value = true;
    var getWorkingHoursRequest = await WorkingHoursServices.getWorkingHours();
    
    workingHours.value = getWorkingHoursRequest!.data!.map((e) {
      String formatTime(String? time) {
        if (time == null) return '';
        DateTime parsedTime = DateFormat("HH:mm").parse(time);
        return DateFormat("h:mma").format(parsedTime);
      }

      String hours;
      if (e.allDay!) {
        hours = '(24h)';
      } else if (!e.allDay! && e.from != null) {
        hours = '(${formatTime(e.from)}-${formatTime(e.to)})';
      } else {
        hours = 'Closed'.tr;
      }
      if (e.datumBreak != false && hours != 'Closed'.tr) {
        hours = "$hours (${formatTime(e.breakFrom)}-${formatTime(e.breakTo)})";
      }
      return {"day": weekcodes[e.day!], "hours": hours};
    }).toList();
    loading.value = false;
  }
//     @override
//   void onInit() {
//     super.onInit();
//     if(Get.arguments ==null)
//     {
// companyDetails.value={
//     "companyData": {
//       'logo': 'assets/images/companyLogo.png',
//       'name': 'Company Name',
//       'phone': '+971 6 500 3245',
//       'address': '32-B Industrial Area 1, Sharjah - UAE'
//     },
//     'manageServices': [
//       'Foam Wash',
//       'Detailed Wash',
//       'Disinfection',
//       'Detailing'
//     ],
//     'businessHours': {
//       "workDays": ,
//       'blockedDates': ['Jan 21 2024', 'Jan 29 2024', 'Feb 13 2024']
//     },
//     'servicesAreas': [
//       {
//         'city': 'Sharjah',
//         'areas': [
//           'Almajaz 1',
//           ' Almajaz 2',
//           'Almajaz 3',
//           'Rolla',
//           'Al Qasmia',
//           'Industrial Area 1',
//           'Industrial Area 2',
//           'Industrial Area 3',
//           'Industrial Area 4',
//           'Industrial Area 5'
//         ]
//       }
//     ],
//     'workers': ['Irshad Abas', 'Laylod Michel', 'Rustam Raj'],
//     'bankAccounts': ['Emirtes NBD', 'Mashriq NEO']
//   };

//     }
//     }
}
