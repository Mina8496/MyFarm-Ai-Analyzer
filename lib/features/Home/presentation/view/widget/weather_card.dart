// weather_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        WeatherLoading() =>
          const Center(child: CircularProgressIndicator()),

        WeatherError(:final message) =>
          WeatherErrorCard(message: message),

        WeatherSuccess(:final data, :final icon, :final description) =>
          WeatherSuccessCard(data: data, icon: icon, description: description),

        _ => const SizedBox.shrink(),
      },
    );
  }
}