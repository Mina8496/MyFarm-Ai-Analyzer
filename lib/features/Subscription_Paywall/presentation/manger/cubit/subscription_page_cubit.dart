import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/Subscription_Paywall/domin/useCase/GetPlans_UseCase.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_state.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  SubscriptionCubit() : super(SubscriptionInitial(plans: [])) {
    _loadPlans();
  }

  late SubscriptionInitial _lastState;

  void _loadPlans() {
    final plans = GetPlansUseCase()().map((e) => e.toViewModel()).toList();
    _lastState = SubscriptionInitial(plans: plans);
    emit(_lastState);
  }

  void selectPlan(int index) {
    _lastState = SubscriptionInitial(
      plans: _lastState.plans,
      selectedIndex: index,
    );
    emit(_lastState);
  }

  void onSubscribeTapped() {
    final user = FirebaseAuth.instance.currentUser;
    final selectedPlan = _lastState.plans[_lastState.selectedIndex];
 
    if (user != null) {
      emit(SubscriptionNavigateToPayment(selectedPlan));
    } else {
      emit(SubscriptionNavigateToLogin());
    }
    emit(_lastState);
  }

}
