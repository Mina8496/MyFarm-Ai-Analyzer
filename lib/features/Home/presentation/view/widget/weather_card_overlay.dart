import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/home_page_constants.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_card.dart';
import 'package:myfarm/core/function/injection_container.dart';

class WeatherCardOverlay extends StatelessWidget {
  const WeatherCardOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kWeatherCardTop,
      left: kHorizontalPadding,
      right: kHorizontalPadding,
      child: BlocProvider(
        create: (_) => getIt<WeatherCubit>()..getWeather(),
        child: const WeatherCard(),
      ),
    );
  }
}
