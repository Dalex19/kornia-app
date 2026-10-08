import 'package:kornia/core/notifications/notification_event.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<bool> requestPermissions();
  Future<void> show({required String title, required String body, String? payload});
  Stream<NotificationTap> get taps;
  Future<NotificationTap?> getInitialTap();
  Future<void> dispose();
}
  
