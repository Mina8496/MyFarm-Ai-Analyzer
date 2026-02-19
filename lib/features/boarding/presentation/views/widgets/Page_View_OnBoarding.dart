import 'package:flutter/material.dart';
import 'package:myfarm/features/boarding/presentation/controllers/controller_onboarding.dart';
import 'package:myfarm/features/boarding/presentation/views/widgets/TextView_PageView_Item.dart';

class PageViewOnBoarding extends StatelessWidget {
  const PageViewOnBoarding({super.key, required this.controller});

  final ControllerOnboardingPage controller;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: controller.pageController,
      onPageChanged: (index) => controller.currentIndex.value = index,
      itemCount: controller.items.length,
      itemBuilder: (_, index) {
        final item = controller.items[index];

        return Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(item.image, fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.3)),

            TextViewPageViewItem(item: item),
          ],
        );
      },
    );
  }
}
