import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:myfarm/features/Subscription_Paywall/domin/useCase/GetPlans_UseCase.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/manger/cubit/subscription_page_state.dart';
import 'package:myfarm/features/payment/domain/entities/billing_data.dart';
import 'package:myfarm/features/payment/domain/repository_imp/current_user_service.dart';
import 'package:myfarm/features/payment/presentation/screens/payment_screen.dart';

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

  void onSubscribeTapped() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      emit(SubscriptionNavigateToPayment());
      final userData = await CurrentUserService().getCurrentUserData();

      if (userData == null) {
        Get.snackbar('خطأ', 'لم يتم العثور على بيانات المستخدم');
        return;
      }
      final fullName = (userData['name'] ?? '').toString();
      final parts = fullName.trim().split(' ');

      final firstName = parts.isNotEmpty ? parts.first : '';
      final lastName = parts.length > 1 ? parts.sublist(1).join(' ') : '';

      Get.to(
        () => PaymentScreen(
          amountCents: 10000, // 100.00 EGP
          billingData: BillingData(
            firstName: firstName,
            lastName: lastName,
            email: userData['email'] ?? '',
            phone: userData['phone'] ?? '',
            city: 'Cairo',
            country: 'EG',
          ),
        ),
      );
    } else {
      emit(SubscriptionNavigateToLogin());
    }
    emit(_lastState);
  }

  void onFreeTrialTapped() {}
}
