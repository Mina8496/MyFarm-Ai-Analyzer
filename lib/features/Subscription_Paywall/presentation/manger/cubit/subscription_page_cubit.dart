import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myfarm/features/Subscription_Paywall/domin/useCase/get_plans_usecase.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_plan_model.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_state.dart';
import 'package:myfarm/features/payment/domain/usecase/get_billing_data.dart';

class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetBillingDataUseCase getBillingDataUseCase;

  SubscriptionCubit(this.getBillingDataUseCase)
    : super(SubscriptionInitial(plans: [])) {
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

  Future<void> onSubscribeTapped({required bool isAuthenticated}) async {
    final selectedPlan = _lastState.plans[_lastState.selectedIndex];

    if (isAuthenticated) {
      final billingData = await getBillingDataUseCase.call();
      emit(SubscriptionNavigateToPayment(selectedPlan, billingData));
    } else {
      emit(SubscriptionNavigateToLogin());
    }
    emit(_lastState);
  }
}