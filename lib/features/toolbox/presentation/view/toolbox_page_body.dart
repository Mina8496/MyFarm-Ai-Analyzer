import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../manager/toolboxPage_cubit.dart';

class FeatureBody extends StatelessWidget {
  const FeatureBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FeatureCubit, FeatureState>(
      builder: (context, state) => switch (state) {
        FeatureLoading() || FeatureInitial() =>
          const Center(child: CircularProgressIndicator()),

        FeatureError(:final message) =>
          Center(child: Text(message)),

        FeatureLoaded(:final data) =>
          const SizedBox.shrink(), // TODO: ضيف الـ UI هنا

        _ => const SizedBox.shrink(),
      },
    );
  }
}