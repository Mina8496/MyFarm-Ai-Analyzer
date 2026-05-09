import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/features/Home/presentation/manger/home_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/manger/home_cubit/weather_state.dart';
import 'package:myfarm/features/Home/presentation/view/widget/show_data_weater_card.dart';

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

          final icon = state.icon;
          final description = state.description;

          return ShowDataWeaterCard(temp: temp, description: description, icon: icon, feelsLike: feelsLike, humidity: humidity, windSpeed: windSpeed);
        }

        // WeatherInitial أو أي state تاني
        return const SizedBox.shrink();
      },
    );
  }
}
