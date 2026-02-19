import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/core/routes/app_pages.dart';
import 'package:myfarm/features/UserType/presentation/viewModel/user_types.dart';

class SelectUserTypeController extends GetxController {
  String? selectedType;

/////////////////////////// userTypes ////////////////////////////
final List<UserType> userTypes = [
  UserType(
    title: 'Farmer'.tr,
    image: 'assets/usertype/flah.avif',
    code: 'farmer',
    route: '/signup',
  ),
  UserType(
    title: 'Supervisor'.tr,
    image: 'assets/usertype/moshraf.avif',
    code: 'supervisor',
    route: '/signup',
  ),
  UserType(
    title: 'Farm Owner'.tr,
    image: 'assets/usertype/owner.avif',
    code: 'owner',
    route: '/login',
  ),
  UserType(
    title: 'Doctor'.tr,
    image: 'assets/usertype/Doctor.avif',
    code: 'doctor',
    route: '/signup',
  ),
  UserType(
    title: 'Engineer'.tr,
    image: 'assets/usertype/engner.avif',
    code: 'engineer',
    route: '/signup',
  ),
];
// Function to handle confirmation of selected user type
void onConfirm() {
  final selected = userTypes.firstWhereOrNull(
    (element) => element.code == selectedType,
  );

  // لو مفيش اختيار
  if (selected == null) {
    Get.snackbar(
      'Error'.tr,
      'Please select a user type first.'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return;
  }

  final routeName = selected.route;

  // لو الروت فاضي
  // لو الروت مش موجود في AppPages
  if (!AppPages.pages.any((p) => p.name == routeName)) {
    Get.snackbar(
      'Error'.tr,
      'Route not found.'.tr,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return;
  }

  Get.offAllNamed(routeName);
}

}
