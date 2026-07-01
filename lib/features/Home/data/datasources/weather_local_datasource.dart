import 'dart:convert';
import 'package:hive/hive.dart';

class WeatherLocalDataSource {
  static const String _boxName = 'weatherBox';
  static const String _dataKey = 'weather_data';

  static Future<void> openBox() async {
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<String>(_boxName);
    }
  }

  Box<String> get _box => Hive.box<String>(_boxName);

  Future<void> cacheWeather(Map<String, dynamic> data) async {
    await _box.put(_dataKey, jsonEncode(data));
  }

  Map<String, dynamic>? getCachedWeather() {
    final raw = _box.get(_dataKey);
    if (raw == null) return null;
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  bool get hasCache => _box.containsKey(_dataKey);
}