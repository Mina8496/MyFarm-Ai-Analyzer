import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:myfarm/common/constants/color_palette.dart';
import 'package:myfarm/core/services/biometric_service.dart';
import 'package:myfarm/core/widgets/app_Button.dart';
import 'package:myfarm/core/widgets/app_textView.dart';
import 'package:myfarm/features/UserType/presentation/controller/select_user_type_controller.dart';
import 'package:myfarm/features/UserType/presentation/views/widgets/gridView_user_type.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActionSectionUserTypePage extends StatelessWidget {
  const ActionSectionUserTypePage({super.key, required this.controller});

  final SelectUserTypeController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 80.h),
        AppText(text: 'Please_select_user_type'.tr, color: Colors.white),
        SizedBox(height: 20.h),
        GridviewUserType(),
        SizedBox(height: 45.h),

        Obx(() {
          final isEnabled = controller.selectedType.value != null;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
            transform: Matrix4.identity()..scale(isEnabled ? 1.0 : 0.95),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: isEnabled ? 1.0 : 0.6,
              child: AppButton(
                onTap: isEnabled
                    ? () async {
                        final prefs = await SharedPreferences.getInstance();
                        bool? enabled = prefs.getBool("biometric_enabled");

                        if (enabled == true) {
                          final biometricService = BiometricService();
                          bool authenticated = await biometricService
                              .authenticate();
                          if (!authenticated) return;
                        }

                        controller.onConfirm();
                      }
                    : null,
                backgroundColor: isEnabled
                    ? ColorPalette.kkPrimaryGreen
                    : Colors.grey.shade400,
                textApp: AppText(text: 'Continue'.tr, color: Colors.white),
              ),
            ),
          );
        }),
        SizedBox(height: 150.h),

        ///
      ],
    );
  }
}
