import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:myfarm/features/Subscription_Paywall/domin/Entity/SubscriptionPlan_Entity.dart';

class GetPlansUseCase {
  List<SubscriptionPlan> call() {
    return [
      SubscriptionPlan(title: "Weekly".tr, price: "299.99 ج", duration: "week".tr),
      SubscriptionPlan(
        title: "Yearly".tr,
        price: "1199.99 ج",
        duration: "/ year".tr,
        isBestOffer: true,
      ),
    ];
  }
}
