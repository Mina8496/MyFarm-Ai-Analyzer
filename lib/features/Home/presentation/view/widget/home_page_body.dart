import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/features/PlantTip/presentation/View/plant_Tips_widget.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_card.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/PlantTipsController.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlantTipsController>();

    return Stack(
      children: [
        Column(
          children: [
            AppAuthHeader(
              title: AppHeaderRichText(
                title_1: "Your_location".tr,
                title_2: "title_2",
              ),
            ),

            SizedBox(height: 10.h),
            Expanded(child: PlantTipsWidget(tips: controller.visibleTips)),
          ],
        ),
        Positioned(top: 200, left: 29, right: 29, child: const WeatherCard()),
      ],
    );
  }
}
