import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/features/Home/presentation/view/controller/main_nev_controller_home.dart';
import 'package:myfarm/features/Home/presentation/view/widget/bottom_bar_painter.dart';
import 'package:myfarm/features/Home/presentation/view/widget/build_nav_item.dart';

class CustomBottomBar extends StatelessWidget {
  final MainNavController controller;
  const CustomBottomBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      child: Stack(
        alignment: AlignmentGeometry.bottomCenter,
        children: [
          CustomPaint(
            size: const Size(double.infinity, 100),
            painter: BottomBarPainter(),
          ),
          Positioned(
            bottom: 25,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BuildNavItem(
                  controller: controller,
                  icon: FontAwesomeIcons.house,
                  index: 0,
                ),
                BuildNavItem(
                  controller: controller,
                  icon: FontAwesomeIcons.dollarSign,
                  index: 1,
                ),
                SizedBox(width: 60.w),
                BuildNavItem(
                  controller: controller,
                  icon: FontAwesomeIcons.barsStaggered,
                  index: 3,
                ),
                BuildNavItem(
                  controller: controller,
                  icon: Icons.person_outline,
                  index: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
