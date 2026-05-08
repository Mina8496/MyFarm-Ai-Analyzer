import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/services/location_service.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;

  WeatherCubit({
    required this.weatherService,
    required this.locationService,
  }) : super(WeatherInitial());

  Future<void> getWeather() async {
  emit(WeatherLoading());
  try {
    final pos = await locationService.getCurrentPositionOnly();
    final data = await weatherService.getWeather(
      lat: pos.latitude,
      lon: pos.longitude,
    );
    emit(WeatherSuccess(data));
  } catch (e) {
    emit(WeatherError(e.toString()));
  }
}
}