abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final Map<String, dynamic> data;
  final String icon;
  final String description;

  WeatherSuccess(this.data)
    : icon = _resolveIcon((data['current']['weather_code'] as num).toInt()),
      description = _resolveDescription(
        (data['current']['weather_code'] as num).toInt(),
      );

  static String _resolveIcon(int code) {
    if (code == 0) return "☀️";
    if (code <= 3) return "⛅";
    if (code <= 48) return "🌫️";
    if (code <= 67) return "🌧️";
    if (code <= 77) return "❄️";
    if (code <= 82) return "🌦️";
    if (code <= 99) return "⛈️";
    return "🌤️";
  }

  static String _resolveDescription(int code) {
    if (code == 0) return "صحو تام";
    if (code <= 3) return "غائم جزئياً";
    if (code <= 48) return "ضباب";
    if (code <= 67) return "أمطار";
    if (code <= 77) return "ثلج";
    if (code <= 82) return "زخات مطر";
    if (code <= 99) return "عواصف رعدية";
    return "غير معروف";
  }
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}
