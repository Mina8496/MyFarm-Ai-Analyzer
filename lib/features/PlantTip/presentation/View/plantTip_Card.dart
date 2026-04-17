import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/presentation/View/viewImage_In_PlantTips.dart';

class PlantTipCard extends StatelessWidget {
  final PlantTip tip;

  const PlantTipCard({super.key, required this.tip});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ViewImageInPlantTips(tip: tip),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Center(
              child: AppText(
                text: tip.title,
                textAlign: TextAlign.center,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          AppText(
            text: tip.description,
            fontSize: 14.sp,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 18.h),
        ],
      ),
    );
  }
}
