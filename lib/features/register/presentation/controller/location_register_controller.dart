import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LocationController extends GetxController {
  var locationText = "Location_being_determined".tr.obs;

  final locationTextController = TextEditingController();

  /// تحديث الموقع
  void updateLocation(String value) {
    locationText.value = value;
    locationTextController.text = value;
  }

  @override
  void onInit() {
    super.onInit();
    onLocationTapped(); // تحديد الموقع تلقائياً
  }

  String? validateLocation(String? value) {
    if (value == null || value.trim().isEmpty) {
      return "Location_required".tr;
    }
    return null;
  }

  Future<void> onLocationTapped() async {
    locationText.value = "Location_being_determined".tr;

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        updateLocation("Location_service_not_enabled".tr);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          updateLocation("permission_denied".tr);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        updateLocation("permission_denied".tr);
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

      updateLocation("$country - $governorate - $city");
    } catch (e) {
      updateLocation("error_occurred_while_determining_location".tr);
    }
  }

  @override
  void onClose() {
    locationTextController.dispose();
    super.onClose();
  }
}
