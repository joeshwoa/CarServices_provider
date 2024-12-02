import 'dart:convert';
import 'dart:io';

import 'package:autoflex/controllers/Company_data/addCompanyData-controller.dart';
import 'package:autoflex/controllers/Company_data/company%20workers/company_workers_controller.dart';
import 'package:autoflex/controllers/Company_data/companyDetails-controller.dart';
import 'package:autoflex/firebase_api.dart';
import 'package:autoflex/locale/translation.dart';
import 'package:autoflex/models/login.dart';
import 'package:autoflex/models/workerHome/woker_orders.dart';
import 'package:autoflex/services/constants.dart';
import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:autoflex/views/Auth/sign-up.dart';
import 'package:autoflex/views/Company_data/addCompanyData.dart';
import 'package:autoflex/views/Company_data/companyDetails.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:autoflex/views/Home/welcome/chooseLang_screen.dart';
import 'package:autoflex/views/Home/welcome/welcome_screen.dart';
import 'package:autoflex/views/Home/worker/pastJobs.dart';
import 'package:autoflex/views/Home/worker/worker-home.dart';
import 'package:autoflex/views/Home/worker/worker_home_offline.dart';
import 'package:autoflex/views/notification_screen.dart';
import 'package:autoflex/views/splashScreen.dart';
import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'views/Company_data/services/manageServices.dart';
import 'firebase_options.dart';
import 'package:http/http.dart' as http;

dynamic isLoggedIn = false;
dynamic token = "";
Login userData = Login();
dynamic localization = "en";
dynamic userType = "";
dynamic welcomed = false;
bool hasInternetConnection = false;


final GlobalKey<NavigatorState> navKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseApi().initNotifications();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var connectivityResult = await Connectivity().checkConnectivity();
  print(connectivityResult);

  if (prefs.get('isLoggedIn') != null) {
    isLoggedIn = prefs.get('isLoggedIn');
    print("isLoggedIn:");
    print(isLoggedIn);
  }

  if (prefs.get('welcomed') != null) {
    welcomed = prefs.get('welcomed');
    print("welcomed:");
    print(welcomed);
  }

  //debugPrint('is Loggend In $isLoggedIn');
  if (prefs.get('token') != null) {
    token = prefs.get('token');
    print(token);
  }

  if (prefs.get('localization') != null) {
    localization = prefs.get('localization');
  }
  if (prefs.get('userData') != null) {
    userData = loginFromJson(prefs.getString('userData')!);
  }
  if (prefs.get('userType') != null) {
    userType = prefs.get('userType');
  }

  if((userType == "Worker" || userType == "العامل") && token != null && (token as String).isNotEmpty) {
    if (connectivityResult[0] != ConnectivityResult.none) {
      // Connected to a mobile network.
      print('Connected to a mobile network');
      hasInternetConnection = true;

      var response =
      await http.get(Uri.parse('https://autoflex.innovationbox.ae/api/v1/worker/orders?future=${ DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: 1)))}'), headers: {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'Authorization':
        'Bearer $token',
        'iso': localization
      });
      if (response.statusCode == 200 || response.statusCode == 201) {
        prefs.setString('WorkerOrders', response.body);
      }

      List<String> updateOrderStatusQueue = prefs.getStringList(
          'updateOrderStatusQueue') ?? [];
      for(int i = 0; i < updateOrderStatusQueue.length; i++) {
        final response = await http.put(Uri.parse('https://autoflex.innovationbox.ae/api/v1/worker/orders/${jsonDecode(updateOrderStatusQueue[i])['orderId']}'), headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': 'Bearer $token',
          'iso': localization
        }, body: json.encode({
          'status': jsonDecode(updateOrderStatusQueue[i])['status']
        }));
        print(response.body);
      }

    } else {
      // No connection.
      print('No internet connection');
      hasInternetConnection = false;
    }
  }
  /* WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); */
  //COMMENT TO REMOVE CHUCKER
  ChuckerFlutter.showOnRelease = false;
  ChuckerFlutter.showNotification = false;
  runApp(const MyApp());
  /* await Future.delayed(const Duration(seconds: 0), FlutterNativeSplash.remove); */
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.putAsync<SharedPreferences>(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs;
    }, tag: 'tagsAreEverywhere', permanent: true);
    final SharedPreferenceController pref = Get.put(
        SharedPreferenceController(),
        tag: 'tagsAreEverywhere',
        permanent: true);

    pref.userToken.value = token;
    pref.isLoggedIn.value = isLoggedIn;
    if (isLoggedIn) {
      pref.localization.value = localization;
      pref.userData.value = userData;
    }
    pref.userType.value = userType;
    pref.welcomed.value = welcomed;
    Future<String?> _getId() async {
      var deviceInfo = DeviceInfoPlugin();
      if (Platform.isIOS) {
        // import 'dart:io'
        var iosDeviceInfo = await deviceInfo.iosInfo;
        return iosDeviceInfo.identifierForVendor; // unique ID on iOS
      } else {
        var androidDeviceInfo = await deviceInfo.androidInfo;
        return androidDeviceInfo.id; // unique ID on Android
      }
    }

    Future.delayed(const Duration(milliseconds: 3000)).then((value) {
      _getId().then((value) {
        pref.uuid.value = value!;
        print('android identifier2 ${pref.uuid.value}');
        pref.setValue('uuid', value);
      });
    });
    if (isLoggedIn) {
      final CompanyDetailsController companyDetailsController =
          Get.put(CompanyDetailsController());
      final AddCompanyDataController addcompanyDataController =
          Get.put(AddCompanyDataController());
      final CompanyWorkersDetailsController companyWorkersDetailsController =
          Get.put(CompanyWorkersDetailsController());
    }
    Map<int, Color> colorCodes = {
      50: const Color.fromRGBO(0, 47, 108, .1),
      100: const Color.fromRGBO(0, 47, 108, .2),
      200: const Color.fromRGBO(0, 47, 108, .3),
      300: const Color.fromRGBO(0, 47, 108, .4),
      400: const Color.fromRGBO(0, 47, 108, .5),
      500: const Color.fromRGBO(0, 47, 108, .6),
      600: const Color.fromRGBO(0, 47, 108, .7),
      700: const Color.fromRGBO(0, 47, 108, .8),
      800: const Color.fromRGBO(0, 47, 108, .9),
      900: const Color.fromRGBO(0, 47, 108, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xff002F6C, colorCodes);
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(
        title: 'Auto Flex',
        //COMMENT TO REMOVE CHUCKER
        navigatorObservers: [ChuckerFlutter.navigatorObserver],
        theme: ThemeData(
            colorScheme: ColorScheme(
                onSurface: Color(0xfff2f2f2),
                primary: colorCustom,
                onSecondary: ConstantColors.secondaryColor,
                surface: Color.fromRGBO(118, 118, 128, .12),
                secondary: ConstantColors.secondaryColor,
                brightness: Brightness.light,
                background: ConstantColors.backgroundColor,
                onBackground: ConstantColors.backgroundColor,
                error: ConstantColors.errorColor,
                onError: ConstantColors.errorColor,
                onPrimary: colorCustom),
            textTheme: TextTheme(
              displaySmall: TextStyle(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF959699),
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              displayLarge: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  overflow: TextOverflow.ellipsis),
              displayMedium: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: ConstantColors.bodyColor,
                overflow: TextOverflow.visible,
              ),
              titleLarge: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              titleMedium: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  overflow: TextOverflow.ellipsis),
              titleSmall: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              labelSmall: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.bodyColor3,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  decoration: TextDecoration.underline),
              labelMedium: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.bodyColor3,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              labelLarge: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              headlineSmall: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              headlineMedium: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              headlineLarge: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.secondaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              bodyLarge: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.bodyColor2,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              bodyMedium: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ConstantColors.bodyColor,
                  overflow: TextOverflow.ellipsis,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont'),
              bodySmall: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: ConstantColors.bodyColor4,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  overflow: TextOverflow.ellipsis),
            ),
            fontFamily: localization == "en"
                ? GoogleFonts.roboto().fontFamily
                : 'DubaiFont',
            primaryColor: ConstantColors.primaryColor,
            hintColor: ConstantColors.hintColor,
            scaffoldBackgroundColor: ConstantColors.backgroundColor),
        home: SplashScreen(),
        // isLoggedIn
        //     ? pref.userType.value == "Worker"
        //         ? WorkerHomeScreen()
        //         : HomeScreen()
        //     : ChooseLangScreen(),
        debugShowCheckedModeBanner: false,
        translations: Translation(),
        locale: Locale(localization),
        fallbackLocale: const Locale('en'),
        navigatorKey: navKey,
        routes: {
          NotificationScreen.route: (context) => const NotificationScreen(),
          HomeScreen.route: (context) => HomeScreen()
        },
      );
    });
  }
}

class SplashNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(isLoggedIn);
    if (isLoggedIn) {
      if (userType == "Worker".tr) {
        return hasInternetConnection ? WorkerHomeScreen() : WorkerHomeOfflineScreen();
      } else {
        print("has company ${userData.data!.hasCompany!}");
        if (userData.data!.hasCompany!) {
          if (userData.data!.isCompleted!) {
            return HomeScreen();
          } else {
            return CompanyDetailsScreen();
          }
        } else {
          return AddCompanyDataScreen();
        }
      }
    } else {
      return !welcomed ? ChooseLangScreen() : SignInScreen();
    }
    //   return isLoggedIn
    //       ? userType == "Worker".tr
    //           ? WorkerHomeScreen()
    //           : userData.data!.hasCompany!?  HomeScreen() : AddCompanyDataScreen()
    //       : ChooseLangScreen();
  }
}
