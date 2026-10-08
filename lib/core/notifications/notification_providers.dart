import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/notifications/fcm_notification_service.dart';
import 'package:kornia/core/notifications/notification_service.dart';

final notificationServiceProvider = Provider<NotificationService>((ref){
   final service = FCMNotificationService();
   ref.onDispose(() => service.dispose());
   return service;
   
});
  