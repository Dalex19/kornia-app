import 'package:firebase_messaging/firebase_messaging.dart';

Future <void>  requestNotificationPermission() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );
  if  (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("Permission granted");
  }else{
    print("Permission denied");
  }
}
