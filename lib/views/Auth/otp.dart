import 'package:autoflex/controllers/Auth/otp-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/shared/components/formSubmitButton.dart';
import 'package:autoflex/shared/components/loading.dart';
import 'package:autoflex/shared/components/loadingButton.dart';
import 'package:autoflex/shared/styles/colors.dart';
import 'package:autoflex/shared/styles/icons_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_countdown_timer/index.dart';

import '../../controllers/Auth/success-screen.dart';


class OtpScreen extends StatefulWidget {
  final String token;
  final String phone;
  OtpScreen({super.key, required this.token, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  int endTime = DateTime.now().millisecondsSinceEpoch +
      Duration(minutes: 3).inMilliseconds;

        final CountdownTimerController timerController =
      Get.put(CountdownTimerController(endTime: 3));

  final OtpController controller = Get.put(OtpController());

  @override
  void initState() {
    controller.mobileNumber.value = widget.phone;
    controller.requestOtp(token: widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
       Obx(()=>
      Scaffold(
              backgroundColor: ConstantColors.backgroundColor,
              appBar: AppBar(

                elevation: 0.0,
                backgroundColor: ConstantColors.backgroundColor,
                leading:   Padding(
                  padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: IconButton(
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
                ),


                centerTitle: true,
                title: Padding(
                 padding: const EdgeInsetsDirectional.only(top: 16.0),
                  child: Text('VERIFICATION'.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleLarge),
                ),
                                           ),
              body: Padding(
                  padding: const EdgeInsetsDirectional.symmetric(horizontal: 16.0),
                  child: Column(children: [
                    const SizedBox(
                          height: 32,
                        ),
                        Text('Please enter the verification code sent to your mobile number'.tr,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff959699),
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  ),),
                    const SizedBox(
                          height: 16,
                        ),
                             Text(controller.mobileNumber.value,
                        overflow: TextOverflow.visible,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: ConstantColors.primaryColor,
                  fontFamily: localization == "en"
                      ? GoogleFonts.roboto().fontFamily
                      : 'DubaiFont',
                  ),),
                   Padding(
                     padding: const EdgeInsets.symmetric(vertical:40.0),
                     child: Center(
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                         children: [
                           OtpTextField(
                             numberOfFields: 4,
                             filled: true,
                          fillColor:ConstantColors.cardColor,
                             focusedBorderColor: ConstantColors.primaryColor,
                             contentPadding: EdgeInsets.symmetric(vertical: 8),
                             borderRadius:
                                 BorderRadius.all(Radius.circular(5.0)),
                             textStyle: TextStyle(
                                 fontSize: 21.0,
                                 color: ConstantColors.primaryColor,
                                 fontFamily:
                                     GoogleFonts.roboto().fontFamily),
                             borderWidth: 1.0,
                             fieldWidth: 40.0,
                             fieldHeight:40.0,
                             mainAxisAlignment: MainAxisAlignment.start,
                             autoFocus: true,

                             showFieldAsBox: true,

                             onCodeChanged: (String code) {
                               //handle validation or checks here
                             },
                             //runs when every textfield is filled
                             onSubmit: (String otp) {
                               controller.otpToken.value=otp;
                            print(controller.otpToken.value);
                             }, // end onSubmit
                           ),
                         ],
                       ),
                     ),
                   ),
                    controller.loading.value ? LoadingButton() : FormSubmitButton(label: 'Submit'.tr,context:  context,
                                                        onPressed: (){
                                                          if (controller.otpToken.value.length == 4 && widget.token.isNotEmpty) {
                                                            controller.verifyOtp(token: widget.token);
                                                          }
                                                         } ),
                                                        // const SizedBox(height: 40,),
                      !controller.success.value &&
                              !controller.otpResendSuccess.value
                          ? Text(
                            '${controller.errorMessage.value}',
                            style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.red[400],
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    GoogleFonts.tajawal().fontFamily),
                          )
                          : Text(''),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Did not receive OTP?'.tr,
                            style: TextStyle(
                                fontSize: 17.0,
                                color: Color(0xff959699),
                                fontFamily: GoogleFonts.roboto().fontFamily),
                          ),
                          // SizedBox(
                          //   width: 5.0,
                          // ),
                          !controller.timerEnd.value
                              ? CountdownTimer(

                                    widgetBuilder: (_, CurrentRemainingTime? time) {
                                    int mins;
                                    int secs;
                                    if (time!.min != null)
                                      mins = time.min!;
                                    else
                                      mins = 0;
                                    if (time.sec != null)
                                      secs = time.sec!;
                                    else
                                      secs = 0;
                                    return Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(' ${mins} : ${secs}',
                                            style: TextStyle(
                                                fontSize: 17.0,
                                        color: ConstantColors.secondaryColor,
                                        fontFamily: GoogleFonts.roboto().fontFamily,
                                        fontWeight: FontWeight.bold,)
                                            ),
                                        SizedBox(
                                          width: 1.5,
                                        ),
                                        Text('min'.tr,
                                            style:   TextStyle(
                                                fontSize: 17.0,
                                        color: ConstantColors.secondaryColor,
                                        fontFamily: GoogleFonts.roboto().fontFamily,
                                        fontWeight: FontWeight.bold,)
                                            ),
                                      ],
                                    );
                                  },

                                  onEnd: () {
                                    controller.timerEnd.value =
                                        true;
                                    endTime = DateTime.now()
                                            .millisecondsSinceEpoch +
                                        Duration(minutes: 3).inMilliseconds;
                                  },
                                  endTime: endTime,
                                )
                              :
                              controller.loading.value ? LoadingButton() :TextButton(
                                  onPressed: () {
                                    controller.requestOtp(token: widget.token);
                                    controller
                                        .otpResendSuccess.value = true;
                                    controller.timerEnd.value =
                                        false;
                                    endTime = DateTime.now()
                                            .millisecondsSinceEpoch +
                                        Duration(minutes: 3).inMilliseconds;
                                  },
                                  child: Text(
                                    'Resend OTP'.tr,
                                    style:  TextStyle(
                                        fontSize: 17.0,
                                        color: ConstantColors.secondaryColor,
                                        fontFamily: GoogleFonts.roboto().fontFamily,
                                        fontWeight: FontWeight.bold,
                                        )
                                    ,
                                  ),
                                ),

                        ],
                      ),
                    ],
                  ),)),
       );}}