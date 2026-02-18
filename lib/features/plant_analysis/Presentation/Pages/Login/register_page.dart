import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/LocationController.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/RegisterController.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/custom_text.dart';
import 'package:myfarm/features/plant_analysis/Presentation/widgets/custom_text_feild.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RegisterController());
    final locationController = Get.put(LocationController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              /// Header
              Container(
                height: 250.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AssetPaths.backGroundBorder),
                    fit: BoxFit.cover,
                    // opacity: 2.9,
                  ),
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(130.r),
                  ),
                ),
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Create_Account'.tr,
                    style: TextStyle(
                      fontSize: 25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(text: '\n'),
                      TextSpan(text: 'Let’s_Create_Account_Together'.tr),
                    ],
                  ),
                ),
              ),
              CustomText(text: 'Your_Name'.tr),
              // name
              CustomeTextField(
                controller: controller.nameController,
                hint: "Full_Name".tr,
              ),
              // Email Addrass
              CustomText(text: 'Email_Address'.tr),
              CustomeTextField(
                controller: controller.emailController,
                keyboardType: TextInputType.emailAddress,
                validator: controller.validateEmail,
                hint: "Enter_valid_email".tr,
              ),

              /// Password
              CustomText(text: 'Password'.tr),
              Obx(
                () => CustomeTextField(
                  controller: controller.passwordController,
                  label: "Password",
                  obscureText: controller.isPasswordHidden.value,
                  validator: controller.validatePassword,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.isPasswordHidden.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),

              /// phone
              CustomText(text: 'Phone_Number'.tr),
              CustomeTextField(
                controller: controller.phoneController,
                hint: "Phone_Number".tr,
                keyboardType: TextInputType.phone,
                validator: controller.validatePhone,
                suffixIcon: const Icon(Icons.phone),
              ),

              /// Location
              CustomText(text: 'Location'.tr),
              Obx(
                () => CustomeTextField(
                  controller: TextEditingController(
                    text: locationController.locationText.value,
                  ),
                  hint: locationController.locationText.value,
                  suffixIcon: const Icon(Icons.location_on),
                  readOnly: true,
                  onTap: () {
                    locationController.getLocation();
                  },
                ),
              ),

              SizedBox(height: 16.h),

              /// Login Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: controller.isLoading.value
                          ? null
                          : controller.register,
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.black)
                          : const Text(
                              'تسجيل دخول',
                              style: TextStyle(color: Colors.black),
                            ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 18.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text('انشئ حساب', style: TextStyle(color: Colors.amber)),
                  SizedBox(width: 40.w),
                  Text('هل لديك حساب؟ ', style: TextStyle(color: Colors.black)),
                ],
              ),
              // const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
