import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/core/widgets/app_textView.dart';

class AchievementsSection extends StatelessWidget {
  final String subtext;
  final String text;
  const AchievementsSection({
    required this.subtext,
    required this.text,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(AssetPaths.vector02, width: 32.w, height: 32.h),
        Column(
          children: [
            AppText(
              text: subtext,
              fontSize: 12,
              color: ColorPalette.kWhiteColor,
            ),
            AppText(text: text, fontSize: 12, color: ColorPalette.kWhiteColor),
          ],
        ),
        Image.asset(AssetPaths.vector01, width: 32.w, height: 32.h),
      ],
    );
  }
}
