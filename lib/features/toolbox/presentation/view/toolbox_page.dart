import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'toolbox_page_body.dart';
import '../manager/toolboxPage_cubit.dart';

class FeaturePage extends StatelessWidget {
  const FeaturePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FeatureCubit()..init(),
      child: const Scaffold(
        body: FeatureBody(),
      ),
    );
  }
}