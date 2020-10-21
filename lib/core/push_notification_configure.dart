import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io';

class PushNotificationConfigure {

  final FirebaseMessaging _fcm = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationDetails platformChannelSpecifics;

  Future<void> configure() async {

    var initializationSettingsAndroid = AndroidInitializationSettings('ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: onSelectNotification);
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );

    var androidPlatformChannelSpecifics = AndroidNotificationDetails('PushNotification id', 'PushNotification name', 'PushNotification description',importance: Importance.Max, priority: Priority.High, ticker: 'ticker');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    platformChannelSpecifics = NotificationDetails(androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _processMessage(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _processMessage(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _processMessage(message);
      },
    );
    print('TOKEN: ${await _fcm.getToken()}');
  }

  void _processMessage(message) {
    _flutterLocalNotificationShow(message);
  }

  Future<void> _flutterLocalNotificationShow(message) async {
    String payload;

    if(Platform.isIOS){
      payload = message['payload'];
    }else{
      payload = message['data']['payload'];
    }
    await flutterLocalNotificationsPlugin.show(0, message['notification']['title'], message['notification']['body'], platformChannelSpecifics, payload: payload);
  }


  static Future myBackgroundMessageHandler(Map<String, dynamic> message) {
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) {
  }

  Future onSelectNotification(String payload) {
  }
}