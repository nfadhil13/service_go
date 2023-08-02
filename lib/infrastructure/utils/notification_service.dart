import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class NotificationService {
  NotificationService();

  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
    'rkn_notification',
    'rukun_app',
    description: 'Rukun Notification',
    importance: Importance.max,
    playSound: true,
  );

  static Future<void> initializeNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('ic_launcher');

    var iosInitializationSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) {});
    try {
      await _notificationsPlugin.initialize(
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        ),
        onDidReceiveNotificationResponse: (details) {
          NotificationUtils.handle(details.payload);
        },
        onDidReceiveBackgroundNotificationResponse:
            _onDidReceiveBackgroundNotificationResponse,
      );
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  @pragma('vm:entry-point')
  static void _onDidReceiveBackgroundNotificationResponse(
      NotificationResponse? details) {}

  static NotificationDetails _notificationDetails(
      BigPictureStyleInformation? bigPictureStyleInformation) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        styleInformation: bigPictureStyleInformation,
      ),
      iOS: const DarwinNotificationDetails(),
    );
  }

  static void onMessage(RemoteMessage message) async {
    print("On meesage");
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    AppleNotification? appleNotification = message.notification?.apple;
    if (notification == null) return;
    if (androidNotification != null || appleNotification != null) {
      _notificationsPlugin.show(notification.hashCode, notification.title,
          notification.body, _notificationDetails(null),
          payload: jsonEncode(message.data));
    }
  }

  static void onMessageOpenedApp(Map<String, dynamic> data) {
    print("On meesage opened app");
    NotificationUtils.handlePayload(data);
  }

  static void onBackgroundOpenedApp(RemoteMessage message) {
    RemoteNotification? notification = message.notification;
    AndroidNotification? androidNotification = message.notification?.android;
    AppleNotification? appleNotification = message.notification?.apple;

    if (notification == null) return;

    if (androidNotification != null || appleNotification != null) {
      _notificationsPlugin.show(notification.hashCode, notification.title,
          notification.body, _notificationDetails(null),
          payload: jsonEncode(message.data));
    }
  }

  static Future<void> requestPermissionsNotification() async {
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<PermissionStatus> getNotificationPermissionStatus() async {
    return await Permission.notification.status;
  }

  Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    print('$id, $title, $body');
    return _notificationsPlugin.show(
      id,
      title,
      body,
      _notificationDetails(null),
    );
  }
}

class NotificationUtils {
  static void handle(String? payload) {
    if (payload == null) return;
    try {
      final decodedJSON = jsonDecode(payload) as Map<String, dynamic>;
      handlePayload(decodedJSON);
    } catch (e) {
      return;
    }
  }

  static void handlePayload(Map<String, dynamic> payload) {
    try {
      final actionType = payload['actionType'];
      switch (actionType) {
        case "open_file":
          break;
        case 'navigate':
          break;
      }
    } catch (e) {
      return;
    }
  }
}
