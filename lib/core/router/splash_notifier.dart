import 'package:flutter/foundation.dart';
import '../services/onboarding_storage_service.dart';
import 'route_names.dart';

/// Notifier que resuelve de forma asíncrona el destino post-splash.
///
/// Flujo:
///   1. SplashScreen programa un Timer de 2500 ms.
///   2. Al dispararse, llama a [resolveDestination].
///   3. [resolveDestination] consulta [OnboardingStorageService] (async)
///      y actualiza [destination] → llama a [notifyListeners].
///   4. GoRouter (registrado con este notifier como [refreshListenable])
///      re-evalúa el redirect y navega al destino correcto.
class SplashNotifier extends ChangeNotifier {
  final OnboardingStorageService _storageService = OnboardingStorageService();

  String? _destination;

  /// [null]  → el splash aún está corriendo; redirect debe esperar.
  /// Non-null → [RouteNames.home] o [RouteNames.onboarding], ya resuelto.
  String? get destination => _destination;

  /// Consulta el storage asíncronamente y fija [destination].
  /// Al llamar a [notifyListeners], GoRouter re-corre el redirect de forma
  /// automática gracias a [refreshListenable].
  Future<void> resolveDestination() async {
    final bool hasSeen = await _storageService.hasSeenOnboarding();
    _destination = hasSeen ? RouteNames.home : RouteNames.onboarding;
    notifyListeners(); // ← desencadena la re-evaluación del redirect en GoRouter
  }

  /// Actualiza síncronamente el destino a [RouteNames.home] cuando el usuario
  /// completa o salta el onboarding, permitiendo que el redirect de GoRouter
  /// autorice el paso hacia `/home`.
  void markOnboardingComplete() {
    _destination = RouteNames.home;
  }
}

/// Instancia global compartida entre [SplashScreen] y [appRouter].
final SplashNotifier splashNotifier = SplashNotifier();
