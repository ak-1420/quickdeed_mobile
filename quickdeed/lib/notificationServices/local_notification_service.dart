import 'dart:math';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<Uint8List> _getByteArrayFromUrl(String url) async {
  final http.Response response = await http.get(Uri.parse(url));
  return response.bodyBytes;
}


class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin
   _notificationPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(GlobalKey<NavigatorState> navigatorKey){
    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: AndroidInitializationSettings('quickdeed_launcher'));
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
      final image = message.data['image'];

       final ByteArrayAndroidBitmap largeIcon = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(image));
      final ByteArrayAndroidBitmap bigPicture = ByteArrayAndroidBitmap(
        await _getByteArrayFromUrl(image));

      final BigPictureStyleInformation bigPictureStyleInformation =
          BigPictureStyleInformation(
              bigPicture,
              largeIcon: largeIcon,
              contentTitle: title,
              htmlFormatContentTitle: true,
              summaryText: body,
              htmlFormatSummaryText: true
          );

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "quickdeed",
            "quickdeed channel",
            icon: "quickdeed_launcher",
            importance: Importance.max,
            priority: Priority.high,
            styleInformation: bigPictureStyleInformation
          )
      );
         await _notificationPlugin.show(id, title, body, notificationDetails,payload: extraData);

    } on Exception catch (e) {
      print('from notification service $e');
    }
 
  }

}