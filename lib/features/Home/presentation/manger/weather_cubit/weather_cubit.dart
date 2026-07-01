import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/services/location_service.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'package:myfarm/features/Home/data/datasources/weather_local_datasource.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherService weatherService;
  final LocationService locationService;
  final WeatherLocalDataSource localDataSource;

  WeatherCubit({
    required this.weatherService,
    required this.locationService,
    required this.localDataSource,
  }) : super(WeatherInitial());

  Future<void> getWeather() async {
    final cached = localDataSource.getCachedWeather();
    if (cached != null) {
      emit(WeatherSuccess(cached, fromCache: true));
    } else {
      emit(WeatherLoading());
    }
    try {
      final pos = await locationService.getCurrentPositionOnly();
      final data = await weatherService.getWeather(
        lat: pos.latitude,
        lon: pos.longitude,
      );
      await localDataSource.cacheWeather(data);

      print("✅ Location: ${pos.latitude}, ${pos.longitude}"); // ← أضف

      emit(WeatherSuccess(data, fromCache: false));

      print("✅ Weather data: $data"); // ← أضف
    } catch (e) {
      if (cached == null) {
        emit(WeatherError(_mapError(e)));
      }
      print("⚠️ تعذر تحديث الطقس، هيفضل الكاش ظاهر: $e");
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
    if (msg.contains('permissionDenied') || msg.contains('denied')) {
      return 'يرجى السماح بالوصول للموقع من إعدادات التطبيق';
    }
    return 'تعذر تحميل بيانات الطقس';
  }
}
