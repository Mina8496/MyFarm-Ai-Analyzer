import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_auth_header.dart';
import 'package:myfarm/core/widgets/app_header_rich_text.dart';
import 'package:myfarm/features/Home/presentation/view/widget/weather_card.dart';
import 'package:myfarm/features/PlantTip/presentation/View/plant_Tips_widget.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_state.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            AppAuthHeader(
              title: AppHeaderRichText(
                title_1: "Your_location",
                title_2: "title_2",
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: BlocBuilder<PlantTipsCubit, PlantTipsState>(
                builder: (context, state) {
                  if (state is PlantTipsLoading || state is PlantTipsInitial) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is PlantTipsError) {
                    return Center(child: Text(state.message));
                  }
                  if (state is PlantTipsLoaded) {
                    return PlantTipsWidget(tips: state.visibleTips);
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        const Positioned(top: 200, left: 29, right: 29, child: WeatherCard()),
      ],
    );
  }
}