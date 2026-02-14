import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Scaffold(
      backgroundColor: const Color(0xFF2F353C),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: controller.fadeAnimation,
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                /// Header
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 9.0.w),
                  child: Container(
                    height: 300.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(130.r),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'تسجيل دخول',
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(8.0.dg),
                  child: SizedBox(
                    width: double.infinity,
                    height: 32.h,
                    child: Text(
                      ':يرجي إدخال البيانات التاليه',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                /// phone
                _inputField(
                  hint: 'ادخل رقم التليفون',
                  icon: Icons.phone_enabled_outlined,
                  controller: controller.phoneController,
                  validator: controller.validatePhone,
                ),
                SizedBox(height: 16.h),

                /// Password
                Obx(
                  () => _inputField(
                    hint: 'ادخل كلمة المرور',
                    icon: Icons.lock,
                    controller: controller.passwordController,
                    validator: controller.validatePassword,
                    isPassword: controller.isPasswordHidden.value,
                    prefixIcon: IconButton(
                      icon: Icon(
                        color: Colors.amber,
                        controller.isPasswordHidden.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(16.w),
                    child: Text(
                      '!نسيت كلمة المرور',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ),
                ),

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
                            : controller.login,
                        child: controller.isLoading.value
                            ? const CircularProgressIndicator(
                                color: Colors.black,
                              )
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
                    Text('انشئ حساب', style: TextStyle(color: Colors.amber)),
                    SizedBox(width: 40.w),
                    Text(
                      'هل لديك حساب؟ ',
                      style: TextStyle(color: Colors.amber),
                    ),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required IconData icon,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool isPassword = false,
    Widget? prefixIcon,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: TextFormField(
        controller: controller,
        textDirection: TextDirection.rtl,
        validator: validator,
        keyboardType: TextInputType.number,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintTextDirection: TextDirection.rtl,
          suffixIcon: Icon(icon, color: Colors.amber),
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      ),
    );
  }
}
