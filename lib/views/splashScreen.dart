import 'package:autoflex/services/shared_preference.dart';
import 'package:autoflex/views/Auth/sign-in.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
final SharedPreferenceController pref =
    Get.find<SharedPreferenceController>(tag: 'tagsAreEverywhere');
class SplashScreen extends StatefulWidget {
   SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool welcomePage = false;
 

  @override
 void initState()  {
    super.initState();

    // print(pref.splash.value);

            // show Welcome Page
          Future.delayed(const Duration(seconds: 3), ()  {
            setState(() {
        welcomePage = true;
      });

          });
  
      }
 

  @override
  Widget build(BuildContext context) {
    return 
    welcomePage == false
        ?
   Scaffold(
  backgroundColor: Colors.black,
  body: Stack(
    children: [
      Image.asset(
        'assets/images/Splash_2.png',
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      ),
    ],
  ),
)
        : SplashNavigator();
       
  }
}
