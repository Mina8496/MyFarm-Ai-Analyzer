import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/PlantTip/presentation/controller/plantTips_controller.dart';

class PlantTips extends StatelessWidget {
  PlantTips({super.key});

  final PlantTipsController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.tips.isEmpty) {
        return const Center(child: Text("No Tips Found"));
      }

      return RefreshIndicator(
        onRefresh: () async => await controller.fetchTips(),
        child: ListView.builder(
          itemCount: controller.tips.length,
          itemBuilder: (context, index) {
            final tip = controller.tips[index];

            return GestureDetector(
              onTap: () {
                // تفاصيل
              },
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(12),
                      ),
                      child: Image.network(
                        tip.image,
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
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
              ),
            );
          },
        ),
      );
    });
  }
}
