import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/features/auth/presentation/controller/location_controller.dart';
import 'package:myfarm/core/widgets/Input_field.dart';

class LocationSignupField extends GetView<LocationController> {
  const LocationSignupField({super.key});

  @override
  Widget build(BuildContext context) {
    return InputField(
      suffixIcon: Icon(Icons.location_on),
      validator: controller.validateLocation,
      textTitke: "Location".tr,
      controller: controller.locationTextController,
      onTap: controller.onLocationTapped,
      readOnly: true,
    );
  }
}
