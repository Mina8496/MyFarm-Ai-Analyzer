import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/services/location_service.dart';
import 'package:myfarm/core/services/weather_service.dart';
import 'package:myfarm/features/Home/data/datasources/weather_local_datasource.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';

import '../controllers/ambient_controller.dart';
import '../widgets/ambient_background.dart';
import '../widgets/ambient_clock.dart';
import '../widgets/ambient_date.dart';
import '../widgets/ambient_myfarm_card.dart';
import '../widgets/ambient_theme.dart';
import '../widgets/ambient_weather_card.dart';

class AmbientScreenPage extends GetView<AmbientController> {
  const AmbientScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AmbientTheme.bgDeep,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: controller.close,
        child: AmbientBackground(
          child: SafeArea(
            child: Center(
              child: Obx(() {
                final settings = controller.settings.value;

                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0, end: 1),
                  duration: const Duration(milliseconds: 700),
                  curve: Curves.easeOut,
                  builder: (context, value, child) => Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, (1 - value) * 12),
                      child: child,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (settings.showClock)
                        AmbientClock(time: controller.time),

                      if (settings.showDate) ...[
                        const SizedBox(height: AmbientTheme.spaceM),
                        AmbientDate(date: controller.date),
                      ],

                      if (settings.showWeather) ...[
                        const SizedBox(height: AmbientTheme.spaceXL),
                        BlocProvider(
                          create: (context) => WeatherCubit(
                            weatherService: WeatherService(),
                            locationService: LocationService(),
                            localDataSource: WeatherLocalDataSource(),
                          )..getWeather(),
                          child: const AmbientWeatherCard(),
                        ),
                      ],

                      if (settings.showMyFarm) ...[
                        const SizedBox(height: AmbientTheme.spaceL),
                        const AmbientMyFarmCard(),
                      ],

                      // if (settings.showLocation) ...[
                      //   const SizedBox(height: AmbientTheme.spaceM),
                      //   const AmbientLocation(),
                      // ],
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
