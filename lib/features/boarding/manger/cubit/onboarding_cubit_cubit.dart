import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/core/services/onboarding_service.dart';
import 'package:myfarm/features/boarding/manger/cubit/onboarding_cubit_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final OnboardingService onboardingService;

  OnboardingCubit(this.onboardingService) : super(OnboardingInitial());

  Future<void> checkOnboarding() async {
    final seen = await onboardingService.hasSeenOnboarding();
    if (seen) {
      emit(OnboardingSeen());
    } else {
      emit(OnboardingNotSeen());
    }
  }
}
