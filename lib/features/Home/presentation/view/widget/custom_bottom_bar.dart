import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myfarm/features/Home/presentation/view/widget/bottom_bar_painter.dart';

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
              children: [
                Icon(FontAwesomeIcons.house, size: 28),
                Icon(FontAwesomeIcons.dollarSign, size: 28),
                SizedBox(width: 60.w),
                Icon(FontAwesomeIcons.barsStaggered, size: 28),
                Icon(Icons.person_outline, size: 28),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
