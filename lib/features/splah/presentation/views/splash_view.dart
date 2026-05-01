import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_cubit.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_state.dart';
import 'package:myfarm/features/splah/presentation/views/widgets/splash_body.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
   @override
  void initState() {
    super.initState();
    context.read<OnboardingCubit>().checkOnboarding();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OnboardingCubit, OnboardingState>(
      listener: (context, state) {
        if (state is OnboardingNotSeen) {
          Get.offAllNamed('/onboarding');
        } else if (state is OnboardingSeen) {
          Get.offAllNamed('/home');
        }
      },
      child: Scaffold(body: SplashViewBody()),
    );
  }
}
