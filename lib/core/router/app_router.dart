import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:liquid_tabbar_minimize/liquid_tabbar_minimize.dart';

import '../../features/home/ui/screens/product_detail_screen.dart';
import '../../features/home/utils/product_items.dart';
import '../../features/info/ui/screens/info_screen.dart';
import '../../features/navigation/ui/screens/main_navigation_screen.dart';
import '../../features/onboarding/ui/screens/onboarding_screen.dart';
import '../../features/splash/ui/screens/splash_screen.dart';
import 'route_names.dart';
import 'splash_notifier.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  observers: [
    LiquidRouteObserver.instance,
  ],

  // GoRouter escucha al notifier: cuando splashNotifier llama a
  // notifyListeners(), se re-evalúa el redirect automáticamente.
  refreshListenable: splashNotifier,

  redirect: (BuildContext context, GoRouterState state) {
    final String location = state.matchedLocation;

    // ── Ruta /splash ──────────────────────────────────────────────────────
    if (location == RouteNames.splash) {
      // [CONSUME] destination == null → el timer aún no terminó; permanece en splash.
      // [CONSUME] destination != null → splashNotifier.resolveDestination() ya corrió;
      //           GoRouter redirige al destino que el notifier decidió (home u onboarding).
      return splashNotifier.destination; // null = quedate, String = ve a esa ruta
    }

    // ── Ruta /onboarding ─────────────────────────────────────────────────
    // El onboarding se muestra a sí mismo sin necesidad de ser redirigido.
    if (location == RouteNames.onboarding) return null;

    // ── Resto de rutas ────────────────────────────────────────────────────
    // Si el notifier ya resolvió y el destino es onboarding, reenvía.
    // Esto cubre el caso en que el usuario llega directamente a /home
    // sin pasar por el splash (ej. hot-reload en desarrollo).
    final String? resolved = splashNotifier.destination;
    if (resolved == RouteNames.onboarding) return RouteNames.onboarding;

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
    ),
    GoRoute(
      path: RouteNames.info,
      builder: (BuildContext context, GoRouterState state) => const InfoScreen(),
    ),
    GoRoute(
      path: RouteNames.productDetail,
      builder: (BuildContext context, GoRouterState state) {
        final String? id = state.pathParameters['id'];

        ProductCardItem item;
        String? heroTag;

        if (state.extra is ProductCardItem) {
          item = state.extra! as ProductCardItem;
          heroTag = 'product_image_${item.id}';
        } else if (state.extra is Map<String, dynamic>) {
          final Map<String, dynamic> extraMap = state.extra! as Map<String, dynamic>;
          item = extraMap['item'] as ProductCardItem? ??
              mockProductItems.firstWhere(
                (p) => p.id == id,
                orElse: () => mockProductItems.first,
              );
          heroTag = extraMap['heroTag'] as String?;
        } else {
          item = mockProductItems.firstWhere(
            (p) => p.id == id,
            orElse: () => mockProductItems.first,
          );
          heroTag = 'product_image_${item.id}';
        }

        return ProductDetailScreen(
          item: item,
          heroTag: heroTag,
        );
      },
    ),
  ],
);
