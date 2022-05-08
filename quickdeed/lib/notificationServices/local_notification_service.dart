import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin
   _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(GlobalKey<NavigatorState> navigatorKey){
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('img'));
    _notificationPlugin.initialize(initializationSettings , onSelectNotification: (String? route) async {
          if(route != null) {
            navigatorKey.currentState?.pushNamed(route);
          }
    });
  }

  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecond;
      final body = message.notification?.body;
      final title = message.notification?.title;
      final extraData = message.data['routePage'];

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "quickdeed",
            "quickdeed channel",
            icon: "img",
            importance: Importance.max,
            priority: Priority.high
          )
      );
         await _notificationPlugin.show(id, title, body, notificationDetails,payload: extraData);
    } on Exception catch (e) {
      print('from notification service $e');
    }
 
  }

}