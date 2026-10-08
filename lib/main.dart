import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kornia/app/bootstrap.dart';
import 'app/router/app_router.dart';
import 'core/theme/app_colors.dart';


void main() async {
final container = await bootstrap();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
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
