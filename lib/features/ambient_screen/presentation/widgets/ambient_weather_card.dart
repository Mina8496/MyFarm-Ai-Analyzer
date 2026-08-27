import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/utils/styles.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_state.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_error_card.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/ambient_theme.dart';

class AmbientWeatherCard extends StatelessWidget {
  const AmbientWeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(
      builder: (context, state) => switch (state) {
        WeatherInitial() => const SizedBox.shrink(),

        WeatherLoading() => const Center(child: CircularProgressIndicator()),

        WeatherError(:final message) => WeatherErrorCard(message: message),

        WeatherSuccess(
          :final data,
          :final icon,
          :final description,
          :final fromCache,
        ) =>
          _buildWeatherCard(
            data: data,
            icon: icon,
            description: description,
            fromCache: fromCache,
          ),
      },
    );
  }

  Widget _buildWeatherCard({
    required Map<String, dynamic> data,
    required String icon,
    required String description,
    required bool fromCache,
  }) {
    final current = data['current'] as Map<String, dynamic>;

    final temperature = current['temperature_2m'];

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AmbientTheme.spaceM,
        vertical: AmbientTheme.spaceS,
      ),
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AmbientTheme.textSecondary),
          bottom: BorderSide(color: AmbientTheme.textSecondary),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(icon, style: Styles.style26),

          const SizedBox(width: 14),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'FIELD CONDITIONS',
                style: TextStyle(
                  color: AmbientTheme.textTertiary,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.6,
                ),
              ),

              const SizedBox(height: 2),

              Text(
                '${temperature.toStringAsFixed(1)}°C · $description',
                style: const TextStyle(
                  color: AmbientTheme.textPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),

              if (fromCache)
                const Padding(
                  padding: EdgeInsets.only(top: 3),
                  child: Text(
                    'CACHED DATA',
                    style: TextStyle(
                      color: AmbientTheme.textTertiary,
                      fontSize: 8,
                      letterSpacing: 1,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
