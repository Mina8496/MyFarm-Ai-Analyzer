import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/core/storage/app_storage.dart';
import 'package:myfarm/features/plant_analysis/Presentation/Controller/animation_helper.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late final SlideAnimationHelper slideHelper;
  // (اختياري) لو مش مستخدمين fadingAnimation أو animationController نحذفهم

  @override
  void initState() {
    super.initState();
    slideHelper = SlideAnimationHelper(vsync: this);
    goToNextView();
  }

  @override
  void dispose() {
    slideHelper.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightGreen,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/back_and_icon/Splash_Scren.png',
            fit: BoxFit.cover,
          ),

          /// 🔹 طبقة شفافة (اختياري عشان النص يبان)
          Container(color: Colors.black.withOpacity(0.3)),
          SlideTransition(
            position: slideHelper.animation,
            child: Image.asset('assets/back_and_icon/Logo-white-1.png'),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),
              Center(
                child: Text(
                  "My Farm",
                  style: TextStyle(
                    fontSize: 20.sp,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void goToNextView() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await Future.delayed(const Duration(seconds: 3));

      final userType = await AppStorage.getUserType();
      if (!mounted) return;

      if (userType == null) {
        Get.offAllNamed('/onboarding'); // المستخدم لم يحدد نوعه بعد
      } else {
        Get.offAllNamed(
          '/onboarding',
        ); // المستخدم موجود، انتقل إلى صفحة البداية
        // أو أي صفحة رئيسية أخرى مثل /homeMain حسب منطق التطبيق
      }
    });
  }
}
