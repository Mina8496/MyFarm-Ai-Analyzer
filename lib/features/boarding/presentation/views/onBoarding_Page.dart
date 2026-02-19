import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:myfarm/features/boarding/presentation/controllers/controller_onboarding.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/OnboardingPageBody.dart';

class OnboardingPage extends GetView<ControllerOnboardingPage> {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return OnboardingPageBody();
      }),
    );
  }
}
