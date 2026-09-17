abstract class RouteNames {
  RouteNames._(); // Evita instanciación

  // Splash & Onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  // Navegación principal / Home
  static const String home = '/home';
  static const String info = '/info';

  // Detalle de producto con parámetro
  static const String productDetail = '/product/:id';

  // Helper para construir la ruta con ID
  static String productDetailPath(String id) => '/product/$id';
}
