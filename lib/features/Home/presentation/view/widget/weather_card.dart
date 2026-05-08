import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/Home/presentation/manger/home_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/manger/home_cubit/weather_state.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is WeatherError) {
          return Card(
            color: Colors.red.shade50,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dg),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.dg),
              child: Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      state.message,
                      style: TextStyle(color: Colors.red, fontSize: 14.sp),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is WeatherSuccess) {
          final current = state.data['current'];
          final temp = current['temperature_2m'];
          final feelsLike = current['apparent_temperature'];
          final humidity = current['relative_humidity_2m'];
          final windSpeed = current['wind_speed_10m'];
          final weatherCode = current['weather_code'] as int;

          final icon = WeatherService().getWeatherIcon(weatherCode);
          final description = WeatherService().getWeatherDescription(
            weatherCode,
          );

          return Card(
            color: Colors.white,
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.dg),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.dg, horizontal: 24.dg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: "${temp.toStringAsFixed(1)}°C",
                            fontSize: 32.sp,
                          ),
                          AppText(
                            text: description,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,
                          ),
                        ],
                      ),
                      Text(icon, style: TextStyle(fontSize: 60.sp)),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  Divider(color: Colors.grey.shade200),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InfoChip(
                        icon: Icons.thermostat,
                        label: "الإحساس",
                        value: "${feelsLike.toStringAsFixed(1)}°C",
                      ),
                      _InfoChip(
                        icon: Icons.water_drop,
                        label: "الرطوبة",
                        value: "$humidity%",
                      ),
                      _InfoChip(
                        icon: Icons.air,
                        label: "الرياح",
                        value: "${windSpeed.toStringAsFixed(1)} m/s",
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }

        // WeatherInitial أو أي state تاني
        return const SizedBox.shrink();
      },
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}
