abstract class RouteNames {
  RouteNames._(); // Evita instanciación

  // Splash & Onboarding
  static const String splash = '/';
  static const String onboarding = '/onboarding';

  //Auth: login, register and recovery password (TODO)
  static const String login = '/login';
  static const String register = '/register';
  static const String recoveryPassword = '/recovery-password';
  

  // Navegación principal / Home
  static const String home = '/home';
  static const String info = '/info';

  // Detalle de producto con parámetro
  static const String productDetail = '/product/:id';

  // Helper para construir la ruta con ID
  static String productDetailPath(int id) => '/product/$id';

  //public routes: 
  static const Set<String> publicRoutes = {splash, onboarding, login, register, recoveryPassword};
    
}
