import 'package:flutter/material.dart';
import 'package:liquid_tabbar_minimize/liquid_tabbar_minimize.dart';
import 'core/theme/app_colors.dart';
import 'features/splash/ui/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kornia',
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        LiquidRouteObserver.instance,
      ],
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
      home: const SplashScreen(),
    );
  }
}

