import 'dart:developer';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:newstart/firebase-management/storeFcmToken.dart';

import '../main.dart';

Future<void> registerOnFirebase(bool isPatient) async {
  //
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  //
  await firebaseMessaging.subscribeToTopic('all');
  //
  await firebaseMessaging.getToken().then(
    (token) async {
      log(token!);
      if (isPatient) {
        await patientSharedPreferences.setString('fcmToken', token);
      } else {
        await studentSharedPreferences.setString('fcmToken', token);
      }
      await storeFcmToken(
        fcmToken: token,
        authToken: patientSharedPreferences.getString('token')!,
      );
    },
  );
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      AndroidNotificationChannel channel;
      if (Platform.isAndroid) {
        channel = const AndroidNotificationChannel(
            'High_importance_channel', 'High Importance Notifications',
            importance: Importance.high,
            enableVibration: true,
            playSound: true,
            enableLights: true);
        flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(channel);
        if (notification != null && android != null) {
          flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  icon: 'launch_background'),
            ),
          );
        }
      }
    },
  );
}
