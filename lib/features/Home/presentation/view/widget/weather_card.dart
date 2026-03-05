import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class WeatherCard extends StatelessWidget {
  const WeatherCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.dg)),
      child: Padding(
        padding: EdgeInsetsGeometry.only(
          top: 10.dg,
          bottom: 10.dg,
          left: 24.dg,
          right: 24.dg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(text: "24.c", fontSize: 24.sp),
                AppText(
                  text: "Your_Location",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            Icon(Icons.cloud, color: Colors.grey, size: 80),
          ],
        ),
      ),
    );
  }
}
