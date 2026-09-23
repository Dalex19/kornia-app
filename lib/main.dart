import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kornia/core/services/notification/get_token.dart';
import 'package:kornia/core/services/notification/local_noti.dart';
import 'package:kornia/core/services/notification/permission_notification.dart';
import 'core/router/app_router.dart';
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
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Kornia',
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
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
