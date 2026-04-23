import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myfarm/core/utils/routes/app_pages.dart';
import 'package:myfarm/features/UserType/presentation/viewModel/user_types.dart';

class SelectUserTypeController extends GetxController {
  RxnString selectedType = RxnString();

  /////////////////////////// userTypes ////////////////////////////
  final List<UserType> userTypes = [
    UserType(
      title: 'Farmer'.tr,
      image: 'assets/usertype/flah.avif',
      code: 'farmer',
      route: '/SubPage',
    ),
    UserType(
      title: 'Supervisor'.tr,
      image: 'assets/usertype/moshraf.avif',
      code: 'supervisor',
      route: '/SubPage',
    ),
    UserType(
      title: 'Farm Owner'.tr,
      image: 'assets/usertype/owner.avif',
      code: 'owner',
      route: '/SubPage',
    ),
    UserType(
      title: 'Doctor'.tr,
      image: 'assets/usertype/Doctor.avif',
      code: 'doctor',
      route: '/SubPage',
    ),
    UserType(
      title: 'Engineer'.tr,
      image: 'assets/usertype/engner.avif',
      code: 'engineer',
      route: '/SubPage',
    ),
  ];
  // Function to handle confirmation of selected user type

  void selectType(String type) {
    selectedType.value = type;
  }

  void onConfirm() {
    final selected = userTypes.firstWhereOrNull(
      (element) => element.code == selectedType.value,
    );

    // لو مفيش اختيار
    if (selected == null) {
      Get.snackbar(
        'Error'.tr,
        'Please_select_user_type'.tr,
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
        'Route_not_found'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    Get.offAllNamed(routeName);
  }
}
