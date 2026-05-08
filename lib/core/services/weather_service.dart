import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  Future<Map<String, dynamic>> getWeather({
    required double lat,
    required double lon,
  }) async {
    final url = Uri.parse(
      "https://api.open-meteo.com/v1/forecast"
      "?latitude=$lat"
      "&longitude=$lon"
      "&current=temperature_2m,relative_humidity_2m,weather_code,wind_speed_10m,apparent_temperature"
      "&timezone=Africa%2FCairo"
      "&wind_speed_unit=ms",
    );

    final res = await http.get(url).timeout(const Duration(seconds: 10));

    if (res.statusCode != 200) {
      throw Exception("فشل تحميل الطقس: ${res.statusCode}");
    }

    return jsonDecode(res.body);
  }

  // تحويل weather_code لنص عربي
  String getWeatherDescription(int code) {
    if (code == 0) return "صحو تام";
    if (code <= 3) return "غائم جزئياً";
    if (code <= 48) return "ضباب";
    if (code <= 67) return "أمطار";
    if (code <= 77) return "ثلج";
    if (code <= 82) return "زخات مطر";
    if (code <= 99) return "عواصف رعدية";
    return "غير معروف";
  }

  // تحويل weather_code لأيقونة
  String getWeatherIcon(int code) {
    if (code == 0) return "☀️";
    if (code <= 3) return "⛅";
    if (code <= 48) return "🌫️";
    if (code <= 67) return "🌧️";
    if (code <= 77) return "❄️";
    if (code <= 82) return "🌦️";
    if (code <= 99) return "⛈️";
    return "🌤️";
  }
}