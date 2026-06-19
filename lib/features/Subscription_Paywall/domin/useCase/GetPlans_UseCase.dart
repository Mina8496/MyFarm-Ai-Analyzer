import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myfarm/features/Subscription_Paywall/presentation/ViewModel/subscription_planModel.dart';

class GetPlansUseCase {
  List<SubscriptionPlanViewModel> call() {
    return [
      SubscriptionPlanViewModel(
        title: "Yearly".tr,
        price: "1199.99 ج",
        duration: "/ year".tr,
      ),
      SubscriptionPlanViewModel(
        title: "Weekly".tr,
        price: "299.99 ج",
        duration: "week".tr,
      ),
    ];
  }
}
