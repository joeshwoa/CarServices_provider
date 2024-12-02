import 'dart:convert';

import 'package:autoflex/controllers/Home/home-controller.dart';
import 'package:autoflex/main.dart';
import 'package:autoflex/services/auth/auth_services.dart';
import 'package:autoflex/views/Home/provider/home.dart';
import 'package:autoflex/views/notification_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

Future<void> handleBackgroundMessage (RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

Future<void> handleMessage (RemoteMessage? message) async {
  if(message == null) {
    print('No message received');
    return;
  }

  Get.find<HomeController>().message.value = message;
  navKey.currentState?.pushNamed(
    HomeScreen.route,
  );
  /*navKey.currentState?.pushNamed(
    NotificationScreen.route,
    arguments: message,
  );*/
}




class FirebaseApi {

  static String token = "";

  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.defaultImportance
  );

  final _localNotifications = FlutterLocalNotificationsPlugin();

  Future initPushNotifications () async {
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;

      if(notification == null) {
        return;
      }

      /*navKey.currentState?.pushReplacementNamed(
        HomeScreen.route,
        arguments: message,
      );*/

      Get.find<HomeController>().message.value = message;


      _localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
            icon: '@drawable/ic_launcher'
          ),
        ),
        payload: jsonEncode(message.toMap())
      );
    },);
  }

  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const settings = InitializationSettings(
      android: android,
      iOS: ios,
    );

    await _localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (details) {
        final message = RemoteMessage.fromMap(jsonDecode(details.payload!));
        handleMessage(message);
      },
    );

    final platform = await _localNotifications.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);

  }

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final fCMToken = await _firebaseMessaging.getToken();

    print('Firebase token: $fCMToken');
    token = fCMToken??'';

    if(isLoggedIn) {
      await AuthService.refreshNotToken(role: userType);
    }

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    initPushNotifications();
    initLocalNotifications();
  }
}