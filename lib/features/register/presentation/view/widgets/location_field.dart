import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/features/register/presentation/controller/location_register_controller.dart';
import 'package:myfarm/features/register/presentation/view/widgets/RegisterInputField.dart';

class LocationField extends GetView<LocationController> {
  const LocationField();

  @override
  Widget build(BuildContext context) {
    return RegisterInputField(
      suffixIcon: Icon(Icons.location_on),
      validator: controller.validateLocation,
      textTitke: "Location".tr,
      controller: controller.locationTextController,
      onTap: controller.onLocationTapped,
      readOnly: true,
    );
  }
}
