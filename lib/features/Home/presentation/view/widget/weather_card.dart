// weather_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_state.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_error_card.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_success_card.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) => switch (state) {
        WeatherLoading() => const Center(child: CircularProgressIndicator()),

        WeatherError(:final message) => WeatherErrorCard(message: message),

        WeatherSuccess(
          :final data,
          :final icon,
          :final description,
          :final fromCache,
        ) =>
          Stack(
            children: [
              WeatherSuccessCard(
                data: data,
                icon: icon,
                description: description,
              ),
              if (fromCache)
                Positioned(
                  top: 8.dg,
                  right: 8.dg,
                  child: SizedBox(
                    width: 14.w,
                    height: 14.h,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
            ],
          ),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
