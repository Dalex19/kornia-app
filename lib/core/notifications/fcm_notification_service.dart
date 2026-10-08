

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:kornia/core/notifications/notification_event.dart';
import 'package:kornia/core/notifications/notification_service.dart';
import 'package:kornia/firebase_options.dart';

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('Mensaje en background: ${message.messageId}');
}

class FCMNotificationService implements NotificationService {
    static const _channelId = 'default_channel';
  static const _channelName = 'General';
  static const _topic = 'todos';
  /// Clave dentro de `data` del push que lleva el destino, ej. "product:5".
  static const _payloadKey = 'payload';

   final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _local =
      FlutterLocalNotificationsPlugin();
  final StreamController<NotificationTap> _taps =
      StreamController<NotificationTap>.broadcast();

  int _nextId = 0;

  static const _androidChannel = AndroidNotificationChannel(
    _channelId,
    _channelName,
    importance: Importance.high,
  );

  static const _details = NotificationDetails(
    android: AndroidNotificationDetails(
      _channelId,
      _channelName,
      importance: Importance.high,
      priority: Priority.high,
    ),
    iOS: DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    ),
  );

  @override
  Future<NotificationTap?> getInitialTap()async {
    final message = await _messaging.getInitialMessage();
    if(message == null) return null;

    return NotificationTap(source: NotificationTapSource.terminated, payload: message.data[_payloadKey] as String?);
  }

  @override
  Future<void> initialize() async {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

       const initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      ),
    );

     await _local.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: (response) {
        _taps.add(NotificationTap(
          payload: response.payload,
          source: NotificationTapSource.foreground,
        ));
      },
    );

     await _local
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidChannel);

    await _messaging.subscribeToTopic(_topic);

       // Push recibido con la app abierta: lo dibujamos nosotros.
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;
      show(
        title: notification.title ?? '',
        body: notification.body ?? '',
        payload: message.data[_payloadKey] as String?,
      );
    });

    // Toque con la app en background.
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      _taps.add(NotificationTap(
        payload: message.data[_payloadKey] as String?,
        source: NotificationTapSource.background,
      ));
    });
    
  }

  @override
  Future<bool> requestPermissions() async {
    final settings = await _messaging.requestPermission();

    await _local
    .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
    ?.requestNotificationsPermission();

    return settings.authorizationStatus == AuthorizationStatus.authorized || settings.authorizationStatus == AuthorizationStatus.provisional;
    
  }

  @override
  Future<void> show({required String title, required String body, String? payload}) {
  return _local.show(id: _nextId++, title: title, body: body, notificationDetails: _details, payload: payload);
  }

  @override
  // TODO: implement taps
  Stream<NotificationTap> get taps => _taps.stream;

  @override
  Future<void> dispose() => _taps.close();
    
}