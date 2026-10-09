import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:kornia/app/router/notification_destinations.dart';
import 'package:kornia/core/notifications/notification_event.dart';
import 'package:kornia/core/notifications/notification_providers.dart';
import 'package:kornia/features/auth/presentation/screens/login_screen.dart';
import 'package:kornia/features/auth/presentation/screens/register_screen.dart';
import 'package:kornia/features/auth/presentation/state/auth_state_provider.dart';
import 'package:kornia/features/home/domain/entities/photo_entity.dart';
import 'package:liquid_tabbar_minimize/liquid_tabbar_minimize.dart';

import '../../features/gospel/presentation/screens/gospel_screen.dart';
import '../../features/home/presentation/screens/product_detail_screen.dart';
import '../../features/info/presentation/screens/info_screen.dart';
import '../../features/navigation/presentation/screens/main_navigation_screen.dart';
import '../../features/onboarding/presentation/screens/onboarding_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
import 'route_names.dart';
import 'splash_notifier.dart';


final routerProvider = Provider<GoRouter>((ref) {
 
  // Notifica a GoRouter cuando cambia la sesión.
  final authRefresh = ValueNotifier<int>(0);
  ref.listen(authStateProvider, (_, __) => authRefresh.value++);
  ref.onDispose(authRefresh.dispose);

  String? pendingRoute;


  void handleTap (NotificationTap? tap) {
    final route = routeForNotificationPayload(tap?.payload);
    if (route == null) return;
    pendingRoute = route;
    authRefresh.value++;
  }

  final service = ref.read(notificationServiceProvider);
  final sub = service.taps.listen(handleTap);
  ref.onDispose(sub.cancel);
  service.getInitialTap().then(handleTap);


  final router = GoRouter(
    initialLocation: RouteNames.splash,
    observers: [LiquidRouteObserver.instance],
    // Se reevalúa el redirect si cambia el splash O la sesión.
    refreshListenable: Listenable.merge([splashNotifier, authRefresh]),

    redirect: (context, state) {
      final loc = state.matchedLocation;
      final destination = splashNotifier.destination;
      final auth = ref.read(authStateProvider);

      // 1. Splash sin resolver o Firebase restaurando la sesión: esperar.
      if (destination == null || auth.isLoading) {
        return loc == RouteNames.splash ? null : RouteNames.splash;
      }

      // 2. Primera vez: onboarding antes que nada.
      if (destination == RouteNames.onboarding) {
        return loc == RouteNames.onboarding ? null : RouteNames.onboarding;
      }

      final loggedIn = auth.value != null;
      if (loggedIn && pendingRoute != null) {
        final target = pendingRoute!;
        pendingRoute = null;
        return target;
      }

      // 3. Salir del splash según la sesión.
      if (loc == RouteNames.splash) {
        return loggedIn ? RouteNames.home : RouteNames.login;
      }

      // 4. Sin sesión: solo rutas públicas.
      if (!loggedIn && !RouteNames.publicRoutes.contains(loc)) {
        return RouteNames.login;
      }

      // 5. Con sesión: login y registro ya no tienen sentido.
      if (loggedIn &&
          (loc == RouteNames.login || loc == RouteNames.register)) {
        return RouteNames.home;
      }

      return null;
    },

   
routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.onboarding,
      builder: (BuildContext context, GoRouterState state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (BuildContext context, GoRouterState state) => const MainNavigationScreen(),
      routes: [
        GoRoute(
          path: RouteNames.gospelSegment,
          builder: (BuildContext context, GoRouterState state) => const GospelScreen(),
        ),
      ],
    ),
    GoRoute(
      path: RouteNames.info,
      builder: (BuildContext context, GoRouterState state) => const InfoScreen(),
    ),
    GoRoute(
      path: RouteNames.productDetail,
      builder: (BuildContext context, GoRouterState state) {
        final extra = state.extra as Map<String, dynamic>;
        final item = extra['item'] as PhotoEntity;
        final heroTag = extra['heroTag'] as String;
     
        return ProductDetailScreen(
          item: item,
          heroTag: heroTag,
        );
      },
    ),
    GoRoute(path: RouteNames.login, builder: (context, state) => const LoginScreen()),
    GoRoute(path: RouteNames.register, builder: (context, state) => const RegisterScreen()),
  ],
  );

  ref.onDispose(router.dispose);
  return router;
});
