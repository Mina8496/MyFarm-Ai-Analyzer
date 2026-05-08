abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherSuccess extends WeatherState {
  final Map<String, dynamic> data;

  WeatherSuccess(this.data);
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError(this.message);
}