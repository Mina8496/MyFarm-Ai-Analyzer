import 'package:shared_preferences/shared_preferences.dart';

class AmbientSettingsService {
  static const String _enabledKey = 'ambient_enabled';
  static const String _showClockKey = 'ambient_show_clock';
  static const String _showDateKey = 'ambient_show_date';
  static const String _showWeatherKey = 'ambient_show_weather';
  static const String _showLocationKey = 'ambient_show_location';
  static const String _showMyFarmKey = 'ambient_show_myfarm';
  static const String _timeoutKey = 'ambient_timeout';

  static Future<SharedPreferences> get _prefs async {
    return SharedPreferences.getInstance();
  }

  static Future<bool> isEnabled() async {
    final prefs = await _prefs;
    return prefs.getBool(_enabledKey) ?? false;
  }

  static Future<void> setEnabled(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_enabledKey, value);
  }

  static Future<bool> showClock() async {
    final prefs = await _prefs;
    return prefs.getBool(_showClockKey) ?? true;
  }

  static Future<void> setShowClock(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_showClockKey, value);
  }

  static Future<bool> showDate() async {
    final prefs = await _prefs;
    return prefs.getBool(_showDateKey) ?? true;
  }

  static Future<void> setShowDate(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_showDateKey, value);
  }

  static Future<bool> showWeather() async {
    final prefs = await _prefs;
    return prefs.getBool(_showWeatherKey) ?? true;
  }

  static Future<void> setShowWeather(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_showWeatherKey, value);
  }

  static Future<bool> showLocation() async {
    final prefs = await _prefs;
    return prefs.getBool(_showLocationKey) ?? true;
  }

  static Future<void> setShowLocation(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_showLocationKey, value);
  }

  static Future<bool> showMyFarm() async {
    final prefs = await _prefs;
    return prefs.getBool(_showMyFarmKey) ?? true;
  }

  static Future<void> setShowMyFarm(bool value) async {
    final prefs = await _prefs;
    await prefs.setBool(_showMyFarmKey, value);
  }

  static Future<int> getTimeout() async {
    final prefs = await _prefs;
    return prefs.getInt(_timeoutKey) ?? 30;
  }

  static Future<void> setTimeout(int seconds) async {
    final prefs = await _prefs;
    await prefs.setInt(_timeoutKey, seconds);
  }
}