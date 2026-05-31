import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/features/Home/presentation/view/widget/bottom_bar_painter.dart';
import 'package:myfarm/features/Home/presentation/view/widget/build_nav_item.dart';

class CustomBottomBar extends StatelessWidget {
  const CustomBottomBar({super.key});

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
              children: const [
                BuildNavItem(icon: FontAwesomeIcons.house, index: 0),
                BuildNavItem(icon: FontAwesomeIcons.dollarSign, index: 1),
                SizedBox(width: 60),
                BuildNavItem(icon: FontAwesomeIcons.tree, index: 2),
                BuildNavItem(icon: FontAwesomeIcons.barsStaggered, index: 3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
