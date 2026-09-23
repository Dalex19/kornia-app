import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin _localNotification =
    FlutterLocalNotificationsPlugin();

Future<void> setupLocalNotifications() async {
  const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
  const iosSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  const initSettings = InitializationSettings(
    android: androidSettings,
    iOS: iosSettings,
  );
  await _localNotification.initialize(settings: initSettings);

  const channel = AndroidNotificationChannel(
    'default_channel',
    'General',
    importance: Importance.high,
  );

  final androidPlugin = _localNotification
      .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin
      >();

  await androidPlugin?.createNotificationChannel(channel);
  await androidPlugin?.requestNotificationsPermission();

  final iosPlugin = _localNotification
      .resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin
      >();
  final iosGranted = await iosPlugin?.requestPermissions(
    alert: true,
    badge: true,
    sound: true,
  );
  print("iOS permission granted: $iosGranted");
}

void listenForegroundNotifications() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification? notification = message.notification;

    if (notification != null) {
      _localNotification.show(
        id: notification.hashCode,
        title: notification.title,
        body: notification.body,
        notificationDetails: const NotificationDetails(
          android: AndroidNotificationDetails(
            'default_channel',
            'General',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
      );
    }
  });
}

void listenNotificationTaps() {
  // App abierta desde background (usuario tocó la notificación)
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print(
      "Notificación abierta desde background: ${message.notification?.title}",
    );
    // Aquí luego navegas a la pantalla correspondiente
  });

  // App abierta desde estado terminado (cold start)
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print(
        "App abierta desde notificación (cold start): ${message.notification?.title}",
      );
      // Aquí luego navegas a la pantalla correspondiente
    }
  });
}

Future<void> showTestNotification() async {
  try {
    await _localNotification.show(
      id: 0,
      title: 'Preparando tu pedido',
      body: 'Te avisaremos cuando tengamos mas noticias, sobre tu pedido',
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          'default_channel',
          'General',
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
    print("Notificacion mostrada con exito");
  } catch (e) {
    print('Error al mostrar la notificación: $e');
  }
}
