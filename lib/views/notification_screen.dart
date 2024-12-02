import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const route = '/notification-screen';

  @override
  Widget build(BuildContext context) {
    final RemoteMessage message = ModalRoute.of(context)!.settings.arguments as RemoteMessage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
    Text('Title: ${message.notification?.title}'),
    Text('Body: ${message.notification?.body}'),
    Text('Payload: ${message.data}'),

      ],
    );
  }
}
