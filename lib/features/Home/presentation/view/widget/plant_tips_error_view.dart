import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/home_page_constants.dart';
import 'package:myfarm/features/Home/presentation/view/widget/Retry_Button.dart';

class PlantTipsErrorView extends StatelessWidget {
  final String message;
  const PlantTipsErrorView({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kErrorPaddingH),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off_rounded, size: kErrorIconSize, color: Colors.grey.shade600),
            SizedBox(height: 18.h),
            Text(message, textAlign: TextAlign.center, style: errorTitleStyle),
            SizedBox(height: 10.h),
            Text(kRetryHint, textAlign: TextAlign.center, style: errorSubtitleStyle),
            SizedBox(height: 25.h),
            RetryButton(),
          ],
        ),
      ),
    );
  }
}