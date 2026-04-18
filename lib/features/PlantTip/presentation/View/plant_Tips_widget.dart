import 'package:flutter/material.dart';
import 'package:myfarm/features/PlantTip/domin/Entity/PlantTip.dart';
import 'package:myfarm/features/PlantTip/presentation/View/plantTip_Card.dart';

class PlantTipsWidget extends StatelessWidget {
  final List<PlantTip> tips;

  const PlantTipsWidget({super.key, this.tips = const []});

  @override
  Widget build(BuildContext context) {
    if (tips.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: tips.length,
      itemBuilder: (context, index) {
        final tip = tips[index];

        return PlantTipCard(tip: tip);
      },
    );
  }
}
