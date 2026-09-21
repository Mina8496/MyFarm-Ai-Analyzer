import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';

class RetryButton extends StatelessWidget {
  const RetryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => context.read<PlantTipsCubit>().init(),
      icon: const Icon(Icons.refresh),
      label: const Text('إعادة المحاولة'),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 12.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      ),
    );
  }
}