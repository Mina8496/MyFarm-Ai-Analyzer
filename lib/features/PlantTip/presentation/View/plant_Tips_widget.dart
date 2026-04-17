import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/PlantTipsController.dart';

class PlantTipsWidget extends StatelessWidget {
  const PlantTipsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.find<PlantTipsController>();

      if (controller.visibleTips.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: controller.visibleTips.length,
        itemBuilder: (context, index) {
          final tip = controller.visibleTips[index];

          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.network(
                    tip.imageUrl,
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,

                    // أثناء التحميل
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Container(
                        height: 180,
                        width: double.infinity,
                        color: Colors.grey.shade200,
                        child: const Center(child: CircularProgressIndicator()),
                      );
                    },

                    // في حالة الخطأ (صورة مش موجودة / رابط غلط)
                    errorBuilder: (context, error, stackTrace) {
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    tip.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    tip.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
