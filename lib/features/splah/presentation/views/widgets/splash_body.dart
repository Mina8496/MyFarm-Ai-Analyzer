import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:myfarm/core/storage/app_storage.dart';
import 'package:myfarm/core/utils/Asset_Paths.dart';
import 'package:myfarm/features/splah/presentation/views/widgets/sliding_animation.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<Offset> slidingAnimation;

  @override
  void initState() {
    super.initState();
    initSlidingAnimation();
    goToNextView();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(AssetPaths.background, fit: BoxFit.cover),

          ///  طبقة شفافة
          Container(color: Colors.black.withOpacity(0.3)),

          // logo and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AssetPaths.logo),
              SlidingAnimation(slidingAnimation: slidingAnimation),
              // SizedBox(height: 30.h),
            ],
          ),
        ],
      ),
    );
  }

  void initSlidingAnimation() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    slidingAnimation = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset.zero,
    ).animate(animationController);
    animationController.forward();
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
