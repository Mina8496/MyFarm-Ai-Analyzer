import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class ShowDataWeaterCard extends StatelessWidget {
  const ShowDataWeaterCard({
    super.key,
    required this.temp,
    required this.description,
    required this.icon,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
  });

  final dynamic temp;
  final String description;
  final String icon;
  final dynamic feelsLike;
  final dynamic humidity;
  final dynamic windSpeed;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.dg),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.dg, horizontal: 24.dg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      text: "${temp.toStringAsFixed(1)}°C",
                      fontSize: 32.sp,
                    ),
                    AppText(
                      text: description,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ],
                ),
                Text(icon, style: TextStyle(fontSize: 60.sp)),
              ],
            ),
            SizedBox(height: 12.h),
            Divider(color: Colors.grey.shade200),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _InfoChip(
                  icon: Icons.thermostat,
                  label: "الإحساس",
                  value: "${feelsLike.toStringAsFixed(1)}°C",
                ),
                _InfoChip(
                  icon: Icons.water_drop,
                  label: "الرطوبة",
                  value: "$humidity%",
                ),
                _InfoChip(
                  icon: Icons.air,
                  label: "الرياح",
                  value: "${windSpeed.toStringAsFixed(1)} m/s",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoChip({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ],
    );
  }
}