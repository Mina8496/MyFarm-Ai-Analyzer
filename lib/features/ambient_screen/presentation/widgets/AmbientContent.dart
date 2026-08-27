import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/features/ambient_screen/presentation/controllers/ambient_controller.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/ambient_clock.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/ambient_date.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/ambient_myfarm_card.dart';
import 'package:myfarm/features/ambient_screen/presentation/widgets/ambient_weather_card.dart';

class AmbientContent extends GetView<AmbientController> {
  const AmbientContent();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Obx(
            () {
              final settings = controller.settings.value;

              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (settings.showClock)
                    AmbientClock(
                      time: controller.time,
                    ),

                  if (settings.showDate) ...[
                    const SizedBox(height: 8),
                    AmbientDate(
                      date: controller.date,
                    ),
                  ],

                  if (settings.showWeather) ...[
                    const SizedBox(height: 40),
                    const AmbientWeatherCard(),
                  ],

                  if (settings.showMyFarm) ...[
                    const SizedBox(height: 28),
                    const AmbientMyFarmCard(),
                  ],

                  if (settings.showLocation) ...[
                    const SizedBox(height: 24),
                    // const AmbientLocation(),
                  ],
                ],
              );
            },
          ),
        ),

        Positioned(
          top: 16,
          right: 16,
          child: IconButton(
            onPressed: controller.close,
            icon: const Icon(
              Icons.close_rounded,
              color: Colors.white24,
            ),
          ),
        ),
      ],
    );
  }
}