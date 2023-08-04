import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:service_go/firebase_options.dart';
import 'package:service_go/infrastructure/utils/notification/notification_service.dart';

@pragma('vm:entry-point')
Future<void> _onBackgroundMessage(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("ON BACKGORUND MESSAGE");
}

@injectable
class FirebaseHelper {
  const FirebaseHelper();

  static Future<RemoteMessage?> getInitialMessage() async {
    return await FirebaseMessaging.instance.getInitialMessage();
  }

  static Future<void> setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.onBackgroundMessage(_onBackgroundMessage);
    FirebaseMessaging.onMessage.listen(_onMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenedApp);
  }

  static void _onMessageOpenedApp(RemoteMessage message) async {
    print("On Message opened app ${message.data}");
    await getInitialMessage();
    await getInitialMessage();
    NotificationService.onMessageOpenedApp(message.data);
  }

  static void _onMessage(RemoteMessage message) {
    print("On Message app ${message.data}");
    NotificationService.onMessage(message);
  }

  Future<void> deleteCurrentFCMToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  Future<String?> getFCMToken() async {
    return await FirebaseMessaging.instance.getToken();
  }
}
