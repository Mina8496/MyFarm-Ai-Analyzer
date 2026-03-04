import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const _langKey = 'app_language';
  static const _userTypeKey = 'user_type';
  static const _tokenKey = 'user_token';
  static const _biometricKey = 'biometric_enabled';

  /// ================= Language =================

  static Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }

  /// ================= User Type =================

  static Future<void> saveUserType(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, code);
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

  /// ================= Token =================

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  /// ================= Biometric =================

  static Future<void> saveBiometricEnabled(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricKey, value);
  }

  static Future<bool?> getBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricKey);
  }
}