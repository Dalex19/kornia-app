import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/core/notifications/get_token.dart';
import 'package:kornia/core/notifications/local_noti.dart';
import 'package:kornia/core/notifications/permission_notification.dart';
import 'app/router/app_router.dart';
import 'core/theme/app_colors.dart';
import 'firebase_options.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  print("Handling background message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await requestNotificationPermission();
  await getToken();
  await setupLocalNotifications();
  listenForegroundNotifications();
  listenNotificationTaps();

  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Kornia',
      debugShowCheckedModeBanner: false,
      routerConfig: ref.watch(routerProvider),
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.darkBackground,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.bronzeGold,
          brightness: Brightness.dark,
          surface: AppColors.darkSurface,
          primary: AppColors.bronzeGold,
          secondary: AppColors.terracotta,
        ),
      ),
    );
  }
}
