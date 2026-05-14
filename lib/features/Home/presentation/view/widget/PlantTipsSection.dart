// _plant_tips_section.dart  (private widget)
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/Home/presentation/view/widget/plantTips_Error_view.dart';
import 'package:myfarm/features/PlantTip/presentation/View/plant_Tips_widget.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_cubit.dart';
import 'package:myfarm/features/PlantTip/presentation/manger/plant_tips_cubit/plant_tips_state.dart';

class PlantTipsSection extends StatelessWidget {
  const PlantTipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlantTipsCubit, PlantTipsState>(
      builder: (context, state) => switch (state) {
  PlantTipsLoading() || PlantTipsInitial() =>
    const Center(child: CircularProgressIndicator()),

  PlantTipsError(:final message) =>
    PlantTipsErrorView(message: message),

  PlantTipsLoaded(:final visibleTips) =>
    PlantTipsWidget(tips: visibleTips),

  _ => const SizedBox.shrink(),
}
    );
  }
}