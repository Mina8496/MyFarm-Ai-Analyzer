import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LocationController extends GetxController {
  final locationController = TextEditingController();

  var locationText = "Location_being_determined".tr.obs;

  @override
  void onInit() {
    super.onInit();
    getLocation(); // تحديد تلقائي عند فتح الصفحة
  }

  Future<void> getLocation() async {
    locationText.value =
        "Location_being_determined".tr; // تحديث النص أثناء تحديد الموقع
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        locationText.value = "Location_service_not_enabled".tr;
        locationController.text = locationText.value;

        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          locationText.value = "permission_denied".tr;
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        locationText.value = "permission_denied".tr;
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks.first;

      String country = place.country ?? "";
      String governorate = place.administrativeArea ?? "";
      String city = place.locality ?? "";

      locationText.value = "$country - $governorate - $city";
      locationController.text = locationText.value;
    } catch (e) {
      locationText.value = "error_occurred_while_determining_location".tr;
    }
  }

  @override
  void onClose() {
    locationController.dispose();
    super.onClose();
  }
}
