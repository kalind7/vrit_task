import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:vrit_task/view/components/export_components.dart';

void onDidReceiveNotificationResponse(
  NotificationResponse notificationResponse,
) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    log('notification payload: $payload');
  }
}

class NotificationController {
  final _firebaseMessaging = FirebaseMessaging.instance;

  final _androidChannel = const AndroidNotificationChannel(
    'vrit_id',
    'vrit_tech_org',
    description: 'IT organization',
    importance: Importance.high,
    enableLights: true,
    ledColor: Colors.blue,
    enableVibration: true,
    showBadge: true,
    playSound: true,
  );

//background message handlerz
  static Future<dynamic> handleBackgroundMessage(RemoteMessage message) async {
    log("on Background ${message.notification?.title}");
    log("on Background Body${message.notification?.body}");
    log("on Background Data${message.data}");
  }

  final _localNotificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    // await getFcmToken();
    // refreshFcmToken();
    initPushNotifications();
    initLocalNotifications();
  }

  Future<void> showNotification({String? username}) async {
    await _localNotificationPlugin.show(
      0,
      'Happy Birthday $username',
      'Wish you many many happy returns of the day.',
      NotificationDetails(
          android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
      )),
    );
  }

  //handle Message
  void handleMessage(RemoteMessage? message) {
    if (message == null) return;

    // Get.toNamed(BasePage.id);
  }

  //push notification for ios
  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);

    _firebaseMessaging.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);

    //handle notification for background
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    //handle notification for foreground
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      _localNotificationPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
              android: AndroidNotificationDetails(
            _androidChannel.id,
            _androidChannel.name,
            channelDescription: _androidChannel.description,
          )),
          payload: jsonEncode(message.toMap()));
    });
  }

  //init local notificarions.
  Future initLocalNotifications() async {
    const ios = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('vrittech');
    const settings = InitializationSettings(android: android, iOS: ios);

    await _localNotificationPlugin.initialize(settings,
        onDidReceiveBackgroundNotificationResponse:
            onDidReceiveNotificationResponse,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _localNotificationPlugin.getNotificationAppLaunchDetails();

    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      if (notificationAppLaunchDetails?.notificationResponse?.payload != null) {
        final message = RemoteMessage.fromMap(jsonDecode(
            notificationAppLaunchDetails!.notificationResponse!.payload!));
        handleMessage(message);
      } else {
        showBotToast(text: 'Error in navigation', isError: true);
      }
    }

    final platform =
        _localNotificationPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    final iosPlatform =
        _localNotificationPlugin.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    await platform?.createNotificationChannel(_androidChannel);
    await iosPlatform?.getActiveNotifications();
  }
}
