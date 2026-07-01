import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/common/constants/home_page_constants.dart';
import 'package:myfarm/core/services/location_service.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_card.dart';

class WeatherCardOverlay extends StatelessWidget {
  const WeatherCardOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kWeatherCardTop,
      left: kHorizontalPadding,
      right: kHorizontalPadding,
      child: BlocProvider(
        create: (_) => WeatherCubit(
          weatherService: WeatherService(),
          locationService: LocationService(),
        )..getWeather(),
        child: const WeatherCard(),
      ),
    );
  }
}