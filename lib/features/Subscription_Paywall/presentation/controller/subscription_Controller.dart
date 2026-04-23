import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SubscriptionController extends GetxController {
  var selectedIndex = 0.obs;

  void selectPlan(int index) {
    selectedIndex.value = index;
  }
}