import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';

class ViewImageInPlantTips extends StatelessWidget {
  const ViewImageInPlantTips({super.key, required this.tip});

  final PlantTip tip;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      child: CachedNetworkImage(
        imageUrl: tip.imageUrl,
        height: 180,
        width: double.infinity,
        fit: BoxFit.cover,

        // أثناء التحميل
        placeholder: (context, url) => Container(
          height: 180,
          width: double.infinity,
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator()),
        ),

        // في حالة الخطأ (صورة مش موجودة / رابط غلط)
        errorWidget: (context, error, url) {
          return Container(
            height: 180,
            width: double.infinity,
            color: Colors.grey.shade200,
            child: Image.asset(
              "assets/boarding/third.jpg",
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}
