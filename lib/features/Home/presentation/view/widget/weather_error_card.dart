import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/features/Home/presentation/manger/weather_cubit/weather_cubit.dart';

class WeatherErrorCard extends StatelessWidget {
  const WeatherErrorCard({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange.shade50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.dg),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Row(
          children: [
            Icon(Icons.cloud_off_rounded, color: Colors.orange.shade700, size: 28.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'تعذر تحميل الطقس',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: Colors.orange.shade800,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    message,
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(Icons.refresh, color: Colors.orange.shade700),
              onPressed: () => context.read<WeatherCubit>().getWeather(),
            ),
          ],
        ),
      ),
    );
  }
}