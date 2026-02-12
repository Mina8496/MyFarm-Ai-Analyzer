import 'package:shared_preferences/shared_preferences.dart';

class AppStorage {
  static const _langKey = 'app_language';
  static const _userTypeKey = 'user_type';

  static Future<void> saveLanguage(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_langKey, code);
  }


  static Future<void> saveUserType(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userTypeKey, code);
  }

  static Future<String?> getUserType() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userTypeKey);
  }

}
