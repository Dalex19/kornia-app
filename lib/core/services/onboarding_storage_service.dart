import 'package:shared_preferences/shared_preferences.dart';

class OnboardingStorageService {
  static const String _seenOnboardingKey = 'seen_onboarding';

  Future<bool> hasSeenOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_seenOnboardingKey) ?? false;
  }

  Future<void> setSeenOnboarding(bool seen) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_seenOnboardingKey, seen);
  }

  Future<void> resetOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_seenOnboardingKey);
  }
}
