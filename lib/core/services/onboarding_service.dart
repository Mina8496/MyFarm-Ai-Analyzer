import 'package:shared_preferences/shared_preferences.dart';

class OnboardingService {
  static const _key = 'seen_onboarding';

  Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_key) ?? false;
  }

  Future<void> markAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_key, true);
  }
}