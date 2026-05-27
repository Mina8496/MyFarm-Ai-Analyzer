import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/services/location_service.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;

  WeatherCubit({required this.weatherService, required this.locationService})
    : super(WeatherInitial());

  Future<void> getWeather() async {
    emit(WeatherLoading());
    try {
      final pos = await locationService.getCurrentPositionOnly();
      print("✅ Location: ${pos.latitude}, ${pos.longitude}"); // ← أضف

      final data = await weatherService.getWeather(
        lat: pos.latitude,
        lon: pos.longitude,
      );
      print("✅ Weather data: $data"); // ← أضف

      emit(WeatherSuccess(data));
    } catch (e) {
      print("❌ Error: $e"); // ← أضف
      emit(WeatherError(_mapError(e)));
    }
  }

  String _mapError(dynamic e) {
    final msg = e.toString();
    if (msg.contains('SocketException') ||
        msg.contains('Failed host lookup') ||
        msg.contains('connectionError')) {
      return 'لا يوجد اتصال بالإنترنت';
    }
    if (msg.contains('TimeoutException') || msg.contains('connectionTimeout')) {
      return 'انتهت مهلة الاتصال، حاول مرة أخرى';
    }
    if (msg.contains('locationServicesDisabled') ||
        msg.contains('LocationServiceDisabledException')) {
      return 'يرجى تفعيل خدمة الموقع';
    }
    if (msg.contains('permissionDenied')) {
      return 'لم يتم منح إذن الموقع';
    }
    if (msg.contains('permissionDenied') || msg.contains('denied')) {
      return 'يرجى السماح بالوصول للموقع من إعدادات التطبيق';
    }
    return 'تعذر تحميل بيانات الطقس';
  }
}
