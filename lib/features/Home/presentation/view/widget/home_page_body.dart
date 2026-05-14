import 'package:flutter/material.dart';
import 'package:myfarm/common/constants/home_page_constants.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/features/Home/presentation/view/widget/PlantTipsSection.dart';
import 'package:myfarm/features/Home/presentation/view/widget/WeatherCardOverlay.dart';


class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            const AppAuthHeader(),
            SizedBox(height: kWeatherCardOffset),
            const Expanded(child: PlantTipsSection()),
          ],
        ),
        const WeatherCardOverlay(),
      ],
    );
  }
}
